if (navigator.serviceWorker) {
  navigator.serviceWorker.register('apps/script/serviceworker.js', { scope: '/' })
    .then(function(reg) {
      console.log('[Companion]', 'Service worker registered!');
    });
}
window.addEventListener('beforeinstallprompt', e => {
  e.preventDefault();
  window.installPromptEvent = e;
});
