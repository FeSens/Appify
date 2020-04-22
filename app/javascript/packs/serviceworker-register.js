var link    =   document.createElement('link');
link.rel    =   'manifest';
link.href   =   'apps/script/manifest.json';
document.head.appendChild(link);

if (navigator.serviceWorker) {
  navigator.serviceWorker.register('apps/script/serviceworker.js', { scope: '/' })
    .then(function(reg) {
      console.log('[Companion]', 'Service worker registered!');
    });
}
