import { idbKeyval } from 'indexdb'

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

if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/apps/script/serviceworker.js', { scope: '/' })
    .then(function(reg) {
      console.log('[Companion]', 'Service worker registered!');
    });
}
window.addEventListener('beforeinstallprompt', e => {
  e.preventDefault();
  window.installPromptEvent = e;
});

window.addEventListener('appinstalled', () => {
  computeSubscriber("pwa")
});

var vapidPublicKey = 'BOrPeoGdzvXg1OuNhjqYpCFof8D5QnDu4v1td5GTBBrXoVU-MhufANWOmWaHLH5ZXv3BUEFmP-I4m9Olme7V_VY';

function checkNotifs(obj){
if (!("Notification" in window)) {                                             //1
      console.error("This browser does not support desktop notification");
    }
    // Let's check whether notification permissions have already been granted
    else if (Notification.permission === "granted") {                           //2
      console.log("Permission to receive notifications has been granted");
      getKeys();
    }
    // Otherwise, we need to ask the user for permission
    else if (Notification.permission !== 'denied') {                            //3
      Notification.requestPermission(function (permission) {                    
            // If the user accepts, let's create a notification
        if (permission === "granted") {                                         //4
          console.log("Permission to receive notifications has been granted");
          getKeys();                                                       
        } 
      });
  }
}

if (navigator.serviceWorker) {
  navigator.serviceWorker.ready.then(function(registration) {
      return registration.pushManager.getSubscription()
        .then(function(subscription) {
          if (subscription) {
            return subscription;
          }
          computeSubscriber("push")
          return registration.pushManager.subscribe({                           //6
            userVisibleOnly: true,
            applicationServerKey: vapidPublicKey
          });
        });
    }).then(function(subscription) {
      sendKeys(subscription)                                           //7
    });
}

function sendKeys(s){
  return $.post('/apps/script/push', {
    subscriber_id: id,
    endpoint: s.endpoint,
    p256dh: btoa(String.fromCharCode.apply(null, new Uint8Array(s.getKey('p256dh')))).replace(/\+/g, '-').replace(/\//g, '_'),
    auth: btoa(String.fromCharCode.apply(null, new Uint8Array(s.getKey('auth')))).replace(/\+/g, '-').replace(/\//g, '_')
  });
}

function computeSubscriber(service) {
  $.post('/apps/script/subscriber_count', { service });
}