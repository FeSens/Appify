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

fetch('https://appify-skin.herokuapp.com/public/checkouts', {
  method: 'post',
  headers: {
    'Content-type': 'application/json'
  },
  body: JSON.stringify({
    subscriber_id: __getCookie__("push-subscriber"),
    utm_campaign: __getCookie__("utm_campaign"),
    checkout_id: `${window.location.pathname.match(/\d{6,10}/i)}`
  })
});
