import { utils } from 'utils'
import BrowserInteractionTime from 'browser-interaction-time'

if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/apps/script/serviceworker.js', { scope: '/' })
    .then(function(reg) {
      console.log('[Companion]', 'Service worker registered!');
      window.saved_reg = reg;
      window.register_push_service = utils.register_push_service;
      if (Notification.permission == 'granted') {
        utils.register_push_service(reg);
      }
  })
}

window.addEventListener('beforeinstallprompt', e => {
  e.preventDefault();
  window.installPromptEvent = e;
});

window.addEventListener('appinstalled', () => {
  computeSubscriber("pwa")
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
