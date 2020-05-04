if (navigator.serviceWorker) {
  navigator.serviceWorker.register('apps/script/serviceworker.js', { scope: '/' })
    .then(function(reg) {
      console.log('[Companion]', 'Service worker registered!');
    });
}
window.addEventListener('beforeinstallprompt', e => {
  e.userChoice.then(choiceResult => {
    $.post("apps/scripts/analytics/installs", choiceResult.outcome);  
//  ga('send', 'event', 'app_install', choiceResult.outcome);
  });
});