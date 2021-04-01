import { utils } from 'universal-utils'
import BrowserInteractionTime from 'browser-interaction-time'

const HOST = "aplicatify"

function install() {
  if (navigator.serviceWorker) {
    navigator.serviceWorker.register('aplicatify-serviceworker.js', { scope: '/' })
      .then(function (reg) {
        console.log('[Companion]', 'Service worker registered!');
        window.saved_reg = reg;
        window.register_push_service = utils.register_push_service;

        var serviceWorker;
        if (reg.installing) {
          serviceWorker = reg.installing;
          // console.log('Service worker installing');
        } else if (reg.waiting) {
          serviceWorker = reg.waiting;
          // console.log('Service worker installed & waiting');
        } else if (reg.active) {
          serviceWorker = reg.active;
          // console.log('Service worker active');
        }

        if (serviceWorker) {
          console.log("sw current state", serviceWorker.state);
          if (serviceWorker.state == "activated") {
            utils.register_push_service(reg).then(function () {
              window.close();
            });
          }
          serviceWorker.addEventListener("statechange", function (e) {
            console.log("sw statechange : ", e.target.state);
            if (e.target.state == "activated") {
              utils.register_push_service(reg).then(function () {
                window.close();
              });
            }
          });
        }
      });
  }
}

install()
setTimeout(install, 5000)

window.addEventListener('beforeinstallprompt', e => {
  e.preventDefault();
  window.installPromptEvent = e;
});

window.browserInteractionTime = new BrowserInteractionTime({
  timeIntervalEllapsedCallbacks: [],
  absoluteTimeEllapsedCallbacks: [],
  browserTabInactiveCallbacks: [],
  browserTabActiveCallbacks: [],
  idleTimeoutMs: 30000,
  checkCallbacksIntervalMs: 250
})

window.browserInteractionTime.startTimer()
utils.init()

window.addEventListener('beforeunload', function() {
  var url = new URL(location)
  !url.host.includes(HOST) && utils.pageVisit();
});
