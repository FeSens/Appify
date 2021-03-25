const ANALYTICS = "https://analytics.pushonaut.com/"
const HOST = "https://subscribers.pushonaut.com/"

var url, shop_id
url || (url = new URL(location)), url.searchParams.get("uuid") && (shop_id = url.shop_id.get("uuid"));

self.addEventListener('install', e => {
  self.skipWaiting();
});



/* This is the  END of "Offline copy of assets" service worker */

/* Main code */

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