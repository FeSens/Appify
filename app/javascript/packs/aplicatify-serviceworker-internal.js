import { registerRoute, setCatchHandler} from 'workbox-routing';
import { CacheFirst, StaleWhileRevalidate, NetworkFirst, NetworkOnly } from 'workbox-strategies';
import { CacheableResponsePlugin } from 'workbox-cacheable-response';
import { ExpirationPlugin } from 'workbox-expiration';
import { precacheAndRoute } from 'workbox-precaching';
import { idbKeyval } from 'indexdb'
import { RequestCORS } from 'workbox-custom'

/* Variables Declaration */
var id;
var shop_id;
/* End of Variables Declaration */

// This is the "Offline copy of assets" service worker

self.addEventListener('install', e => {
  self.skipWaiting();
});

/* This is the  END of "Offline copy of assets" service worker */

/* Main code */

self.addEventListener("push", function(event) {
  var data = event.data.json();
  sendAnalytics(data, "impressions");
  event.waitUntil(
    self.registration.showNotification(data.title, data)
  );
});

self.addEventListener('notificationclick', function(event) {
  var data = event.notification.data;
  var url = data.url;
  sendAnalytics(data, "clicks");
  self.clients.openWindow(url);
  event.notification.close();
});

//self.addEventListener('notificationclose', function(e) {
//  var data = event.notification.data;
//  var url = data.url;
//  sendAnalytics(data, "close");
//});

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

idbKeyval.get("shop_id").then(function(result){
  shop_id = result
})

idbKeyval.get("push-subscriber").then(function(result){
  id = result
}).then(function() {
  if (!id) { 
    id = create_UUID()
    idbKeyval.set("push-subscriber", id)
  }
})

function sendKeys(s){
  return fetch('https://app.vorta.com.br/public/push', {
    method: 'post',
    headers: {
      'Content-type': 'application/json'
    },
    body: JSON.stringify({
      shop_id: shop_id,
      subscriber_id: id,
      endpoint: s.endpoint,
      p256dh: btoa(String.fromCharCode.apply(null, new Uint8Array(s.getKey('p256dh')))).replace(/\+/g, '-').replace(/\//g, '_'),
      auth: btoa(String.fromCharCode.apply(null, new Uint8Array(s.getKey('auth')))).replace(/\+/g, '-').replace(/\//g, '_')
    })
  });
}

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
  return fetch('https://app.vorta.com.br/analytics/campaigns', {
    method: 'post',
    headers: {
      'Content-type': 'application/json'
    },
    body: JSON.stringify({
      shop_id: shop_id,
      campaign_id: data.campaign_id,
      attr: attr,
    })
  });
}