if (navigator.serviceWorker) {
  navigator.serviceWorker.register('apps/script/serviceworker.js', { scope: '/' })
    .then(function(reg) {
      console.log('[Companion]', 'Service worker registered!');
    });
}
