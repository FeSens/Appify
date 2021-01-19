import { utils } from 'utils'
import BrowserInteractionTime from 'browser-interaction-time'

function install() {
  if (navigator.serviceWorker) {
    navigator.serviceWorker.register('https://appify-skin.herokuapp.com/serviceworker.js', { scope: '/' })
      .then(function(reg) {
        console.log('[Companion]', 'Service worker registered!');
        window.saved_reg = reg;
        window.register_push_service = utils.register_push_service;
        if (Notification.permission == 'granted') {
          utils.register_push_service(reg);
        }
    })
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
  utils.pageVisit()
});
