import { utils } from 'universal-utils'
import BrowserInteractionTime from 'browser-interaction-time'

function install() {
  if (navigator.serviceWorker) {
    navigator.serviceWorker.register('aplicatify-serviceworker.js', { scope: '/' })
      .then(function(reg) {
        console.log('[Companion]', 'Service worker registered!');
        window.saved_reg = reg;
        window.register_push_service = utils.register_push_service;
        utils.register_push_service(reg);
    })
  }
}

install()

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

window.addEventListener('beforeunload', function() {
  utils.pageVisit()
});
