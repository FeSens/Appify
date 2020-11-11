import { registerRoute, setCatchHandler} from 'workbox-routing';
import { CacheFirst, StaleWhileRevalidate, NetworkFirst, NetworkOnly } from 'workbox-strategies';
import { CacheableResponsePlugin } from 'workbox-cacheable-response';
import { ExpirationPlugin } from 'workbox-expiration';
import { precacheAndRoute } from 'workbox-precaching';
import { idbKeyval } from 'indexdb'
import { RequestCORS } from 'workbox-custom'
//This is the service worker with the Advanced caching
const HTML_CACHE = "html";
const JS_CACHE = "javascript";
const STYLE_CACHE = "stylesheets";
const IMAGE_CACHE = "images";
const FONT_CACHE = "fonts";
const CACHE = "pwabuilder-offline";

// This is the "Offline copy of assets" service worker

self.addEventListener("message", (event) => {
  if (event.data && event.data.type === "SKIP_WAITING") {
    self.skipWaiting();
  }
});
/*
self.addEventListener('fetch', function (event) {
  const url = new URL(event.request.url)
  if(url.host === "cdn.shopify.com") {
    var req = new Request(event.request, {
      headers: {
        ...event.request.headers,
        origin: location.origin
      }
    })
    event.respondWith(fetch(req));
  } 
  else {
    event.respondWith(fetch(event.request));
  }
});
*/

registerRoute(
  ({event}) => event.request.destination === 'image',
  new StaleWhileRevalidate({
    cacheName: IMAGE_CACHE,
    plugins: [
      new RequestCORS(),
      new CacheableResponsePlugin({
        statuses: [200],
      }),
      new ExpirationPlugin({
        maxEntries: 15, 
        purgeOnQuotaError: true,
      }),
    ],
  })
);

registerRoute(
  ({event}) => event.request.destination === 'font',
  new StaleWhileRevalidate({
    cacheName: FONT_CACHE,
    plugins: [
      new ExpirationPlugin({
        maxEntries: 15, 
        purgeOnQuotaError: true,
      }),
    ],
  })
);

registerRoute(
  ({event}) => event.request.destination === 'script',
  new StaleWhileRevalidate({
    cacheName: JS_CACHE,
    plugins: [
      new CacheableResponsePlugin({
        statuses: [200],
      }),
      new ExpirationPlugin({
        maxEntries: 15, 
        purgeOnQuotaError: true,
      }),
    ],
  })
);

registerRoute(
  ({event}) => event.request.destination === 'style',
  new StaleWhileRevalidate({
    cacheName: STYLE_CACHE,
    plugins: [
      new CacheableResponsePlugin({
        statuses: [0, 200],
      }),
      new ExpirationPlugin({
        maxEntries: 5, 
        purgeOnQuotaError: true,
      }),
    ],
  })
);

registerRoute(
  ({event}) => event.request.destination === 'document',
  new StaleWhileRevalidate({
    cacheName: HTML_CACHE,
    plugins: [
      new CacheableResponsePlugin({
        statuses: [200],
      }),
      new ExpirationPlugin({
        maxEntries: 15, 
        purgeOnQuotaError: true,
      }),
    ],
  })
);

self.addEventListener("push", function(event) {
  var data = event.data.json();
  var title = data.title;
  var body = data.body;
  var tag = data.tag;
  var icon = data.icon;
  var url = data.url;
  var campaign_id = data.campaign_id;
  sendAnalytics(data, "impressions");
  event.waitUntil(
    self.registration.showNotification(title, {
      body: body,
      icon: icon,
      tag: tag,
      requireInteraction: true,
      data: {
        url: url,
        campaign_id: campaign_id
      }
  }));
});

self.addEventListener('notificationclick', function(event) {
  var data = event.notification.data;
  var url = data.url;
  sendAnalytics(data, "clicks");
  self.clients.openWindow(url);
  event.notification.close();
});

self.addEventListener('pushsubscriptionchange', function(event) {
  console.log('Subscription expired');
  event.waitUntil(
    self.registration.pushManager.subscribe({ userVisibleOnly: true })
    .then(function(subscription) {
      console.log('Subscribed after expiration', subscription.endpoint);
      return sendKeys(subscription);
    })
  );
});

function sendKeys(s){
  return fetch('/apps/script/public/push', {
    method: 'post',
    headers: {
      'Content-type': 'application/json'
    },
    body: JSON.stringify({
      subscriber_id: id,
      endpoint: s.endpoint,
      p256dh: btoa(String.fromCharCode.apply(null, new Uint8Array(s.getKey('p256dh')))).replace(/\+/g, '-').replace(/\//g, '_'),
      auth: btoa(String.fromCharCode.apply(null, new Uint8Array(s.getKey('auth')))).replace(/\+/g, '-').replace(/\//g, '_')
    })
  });
}

var id;

idbKeyval.get("push-subscriber").then(function(result){
  id = result
}).then(function() {
  if (!id) { 
    id = create_UUID()
    idbKeyval.set("push-subscriber", id)
  }
})

function create_UUID() {
  var dt = new Date().getTime();
  var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
      var r = (dt + Math.random()*16)%16 | 0;
      dt = Math.floor(dt/16);
      return (c=='x' ? r :(r&0x3|0x8)).toString(16);
  });
  return uuid;
}

function sendAnalytics(data, attr) {
  return fetch('/apps/script/analytics/campaigns', {
    method: 'post',
    headers: {
      'Content-type': 'application/json'
    },
    body: JSON.stringify({
      campaign_id: data.campaign_id,
      attr: attr,
    })
  });
}