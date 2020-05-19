import { idbKeyval } from 'indexdb'

var vapidPublicKey = 'BOrPeoGdzvXg1OuNhjqYpCFof8D5QnDu4v1td5GTBBrXoVU-MhufANWOmWaHLH5ZXv3BUEFmP-I4m9Olme7V_VY';

// move to utils
function get_or_create_id() {
  var id;
  return idbKeyval.get("push-subscriber").then(function(result){
    id = result
  }).then(function() {
    if (!id) { 
      id = create_UUID()
      idbKeyval.set("push-subscriber", id)
    }
    return id
  })
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

//-------

if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/apps/script/serviceworker.js', { scope: '/' })
    .then(function(reg) {
      console.log('[Companion]', 'Service worker registered!');

      return reg.pushManager.getSubscription()
      .then(function(subscription) {
        if (subscription) {
          return subscription;
        }
        computeSubscriber("push")
        return reg.pushManager.subscribe({                           //6
          userVisibleOnly: true,
          applicationServerKey: vapidPublicKey
        });
      });
  }).then(function(subscription) {
    sendKeys(subscription)                                           //7
  });
}

//PWA installer
window.addEventListener('beforeinstallprompt', e => {
  e.preventDefault();
  window.installPromptEvent = e;
});

window.addEventListener('appinstalled', () => {
  computeSubscriber("pwa")
});
//---

//TODO move to utils
function sendKeys(s){
  return $.post('/apps/script/push', {
    subscriber_id: get_or_create_id(),
    endpoint: s.endpoint,
    p256dh: btoa(String.fromCharCode.apply(null, new Uint8Array(s.getKey('p256dh')))).replace(/\+/g, '-').replace(/\//g, '_'),
    auth: btoa(String.fromCharCode.apply(null, new Uint8Array(s.getKey('auth')))).replace(/\+/g, '-').replace(/\//g, '_')
  });
}

function computeSubscriber(service) {
  $.post('/apps/script/subscriber_count', { service });
}
//----