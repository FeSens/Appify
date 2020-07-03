import { idbKeyval } from 'indexdb'

export let utils = (() => {
  var vapidPublicKey = 'BOrPeoGdzvXg1OuNhjqYpCFof8D5QnDu4v1td5GTBBrXoVU-MhufANWOmWaHLH5ZXv3BUEFmP-I4m9Olme7V_VY';

  function setCookie(name, value, days) {
    var expires = "";
    if (days) {
      var date = new Date();
      date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
      expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + (value || "") + expires + "; path=/"
  }
  function getCookie(name) {
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
    var uuid = getCookie(name)
    if (!uuid) {
      uuid = create_UUID()
      setCookie(name, uuid)
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
    return $.post('/apps/script/public/push', {
      subscriber_id: await get_or_create_id(),
      endpoint: s.endpoint,
      p256dh: btoa(String.fromCharCode.apply(null, new Uint8Array(s.getKey('p256dh')))).replace(/\+/g, '-').replace(/\//g, '_'),
      auth: btoa(String.fromCharCode.apply(null, new Uint8Array(s.getKey('auth')))).replace(/\+/g, '-').replace(/\//g, '_')
    });
  }

  function computeSubscriber(service) {
    $.post('/apps/script/analytics/subscribers', { service });
  }

  const pageVisit = async () => {
    return $.post('/apps/script/analytics/page_visits', {
      subscriber_id: await idbKeyval.get("push-subscriber"),
      path: window.location.pathname,
      time_spent: window.browserInteractionTime.getTimeInMilliseconds() | 0,
      data: new Date().getTime(),
      session: getCookie("session"),
      is_available: window.location.pathname.includes("products/")
    });
  }

  const cartBind = async () => {
    Shopify.onCartUpdate = cartSync()
  }

  const cartSync = async () => {
    fetch('./cart.js')
      .then((response) => {
        return response.json()
      })
      .then((data) => {
        // Work with JSON data here
        $.post('/apps/script/analytics/carts', {
          subscriber_id: dbKeyval.get("push-subscriber"),
          token: data['token'],
          data: JSON.stringify(data)
        });
      })
      .catch((err) => {
        console.log('Error parsing cart data')
        console.log(err)
      })
  }
  
  function initialize() {
    get_or_create_id();
    get_or_create_cookie("session");
  }

  return {
    register_push_service(reg) {
      reg.pushManager.getSubscription()
        .then(function (subscription) {
          if (subscription) {
            return subscription;
          }
          return reg.pushManager.subscribe({
            userVisibleOnly: true,
            applicationServerKey: vapidPublicKey
          });
        }).then(function (subscription) {
          sendKeys(subscription)
        });
    },
    pageVisit() {
      pageVisit()
    },
    init() {
      initialize();
      cartBind();
      window.onappinstalled = function(ev) { 
        computeSubscriber("pwa")
      };
    }
  }
})();