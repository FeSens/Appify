import { idbKeyval } from 'indexdb'

export let utils = (() => {
  var vapidPublicKey = 'BOrPeoGdzvXg1OuNhjqYpCFof8D5QnDu4v1td5GTBBrXoVU-MhufANWOmWaHLH5ZXv3BUEFmP-I4m9Olme7V_VY';

  const dig = (target, ...keys) => {
    let digged = target;
    for (const key of keys) {
      if (typeof digged === 'undefined' || digged === null) {
        return undefined;
      }
      if (typeof key === 'function') {
        digged = key(digged);
      } else {
        digged = digged[key];
      }
    };
    return digged; 
  }

  function __setCookie__(name, value) {
    var expires = "";
    document.cookie = name + "=" + (value || "") + expires + "; path=/"
  }
  function __getCookie__(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
      var c = ca[i];
      while (c.charAt(0) == ' ') c = c.substring(1, c.length);
      if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
  }

  function get_or_create_cookie(name) {
    var uuid = __getCookie__(name)
    if (!uuid) {
      uuid = create_UUID()
      __setCookie__(name, uuid)
    }
    return uuid
  }

  function create_UUID() {
    var dt = new Date().getTime();
    var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
      var r = (dt + Math.random() * 16) % 16 | 0;
      dt = Math.floor(dt / 16);
      return (c == 'x' ? r : (r & 0x3 | 0x8)).toString(16);
    });
    return uuid;
  }

  const get_or_create_id = async () => {
    var id = await idbKeyval.get("push-subscriber")
    if (!id) {
      id = create_UUID()
      idbKeyval.set("push-subscriber", id)
    }
    return id
  }

  const sendKeys = async (s) => {
    return $.post('https://app.vorta.com.br/public/push', {
      shop_id: window.AplicatifyShopId,
      subscriber_id: await get_or_create_id(),
      endpoint: s.endpoint,
      p256dh: btoa(String.fromCharCode.apply(null, new Uint8Array(s.getKey('p256dh')))).replace(/\+/g, '-').replace(/\//g, '_'),
      auth: btoa(String.fromCharCode.apply(null, new Uint8Array(s.getKey('auth')))).replace(/\+/g, '-').replace(/\//g, '_')
    });
  }

  function computeSubscriber(service) {
    $.post('https://app.vorta.com.br/analytics/subscribers', { service, shop_id: window.AplicatifyShopId });
  }

  const pageVisit = async () => {
    return $.ajax({
        url: 'https://app.vorta.com.br/analytics/page_visits',
        type: 'POST',
        async: false,
        contentType : "application/json", 
        data: JSON.stringify({
        shop_id: window.AplicatifyShopId,
        subscriber_id: await idbKeyval.get("push-subscriber"),
        path: window.location.pathname,
        time_spent: window.browserInteractionTime.getTimeInMilliseconds() | 0,
        data: new Date().getTime(),
        session: __getCookie__("session"),
        is_available: window.location.pathname.includes("products/")
      })
    })
  }
  
  function initialize() {
    get_or_create_id();
    idbKeyval.set("shop_id", window.AplicatifyShopId)
    get_or_create_cookie("session");
  }

  return {
    register_push_service(reg) {
      return reg.pushManager.getSubscription()
        .then(function (subscription) {
          if (subscription) {
            return subscription;
          }
          return reg.pushManager.subscribe({
            userVisibleOnly: true,
            applicationServerKey: vapidPublicKey
          });
        }).then(function (subscription) {
          return sendKeys(subscription)
        });
    },
    pageVisit() {
      pageVisit()
    },
    init() {
      initialize();
      window.onappinstalled = function(ev) { 
        computeSubscriber("pwa")
      };
    }
  }
})();


