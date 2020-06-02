import { utils } from 'utils'

if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/apps/script/serviceworker.js', { scope: '/' })
    .then(function(reg) {
      console.log('[Companion]', 'Service worker registered!');
      window.saved_reg = reg;
      //utils.register_push_service(reg);
  })
}

window.addEventListener('beforeinstallprompt', e => {
  e.preventDefault();
  window.installPromptEvent = e;
});

window.addEventListener('appinstalled', () => {
  computeSubscriber("pwa")
});
