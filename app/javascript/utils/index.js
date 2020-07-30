import { idbKeyval } from 'indexdb'

export let utils = (() => {
  var vapidPublicKey = 'BOrPeoGdzvXg1OuNhjqYpCFof8D5QnDu4v1td5GTBBrXoVU-MhufANWOmWaHLH5ZXv3BUEFmP-I4m9Olme7V_VY';
  var encapsulated = function (args) {};

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
    return $.ajax({
        url: '/apps/script/analytics/page_visits', 
        type: 'POST',
        async: false,
        contentType : "application/json", 
        data: JSON.stringify({
        subscriber_id: await idbKeyval.get("push-subscriber"),
        path: window.location.pathname,
        time_spent: window.browserInteractionTime.getTimeInMilliseconds() | 0,
        data: new Date().getTime(),
        session: __getCookie__("session"),
        is_available: window.location.pathname.includes("products/")
      })
    })
  }

  function cartBind() {
    var xhr = window.XMLHttpRequest.prototype.open;
    window.XMLHttpRequest.prototype.open = function(method, url) {
      this.addEventListener("readystatechange", function() {
        switch (url) {
          case "/cart/change.js":
          case "/cart/update.js":
            this.readyState === XMLHttpRequest.DONE && cartSync(JSON.parse(this.responseText))
          break
          case "/cart/add":
          case "/cart/add.js":
          case "/cart/add.json":
            this.readyState === XMLHttpRequest.DONE && fetch('/cart.js').then((resp) => resp.json()).then(function(data) {
              cartSync(data)
            })
          }
      })
      xhr.apply(this, arguments)
    }
  }

  const cartSync = async (data) => {
    try {
      if (data['item_count'] != 0){ 
        cartSend(data)
      }
    }
    catch(err) {
      console.log('Error parsing cart data')
      console.log(err)
    }
  }

  const cartSend = async (data) => {
    $.post('/apps/script/analytics/carts', {
      subscriber_id: await idbKeyval.get("push-subscriber"),
      token: data['token'],
      hexdigest: await hashCart(data),
      data: data
    });
  }

  async function hashCart(cart) {
    var s = ""
    for (const [key, value] of Object.entries(cart['items'])) {
      s += `${value['product_id']}${value['variant_id']}${value['sku']}${value['quantity']}`
    }

    return digestMessage(s)
  }

  async function digestMessage(message) {
    const msgUint8 = new TextEncoder().encode(message);                           // encode as (utf-8) Uint8Array
    const hashBuffer = await crypto.subtle.digest('SHA-256', msgUint8);           // hash the message
    const hashArray = Array.from(new Uint8Array(hashBuffer));                     // convert buffer to byte array
    const hashHex = hashArray.map(b => b.toString(16).padStart(2, '0')).join(''); // convert bytes to hex string
    return hashHex;
  }

  
  function initialize() {
    get_or_create_id();
    get_or_create_cookie("session");
    var queryString = window.location.search;
    var searchParams = new URLSearchParams(queryString);
    var cart_attributes = {
      'attributes': {
        'utm_medium': searchParams.get("utm_medium"),
        'utm_campaign': searchParams.get("utm_campaign"),
        'utm_source': searchParams.get("utm_source")
      }
    }
    $.post('/cart/update.js', cart_attributes);
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


