import { utils } from 'universal-utils'

function install() {
  if (navigator.serviceWorker) {
    navigator.serviceWorker.register('aplicatify-serviceworker.js', { scope: '/' })
      .then(function(reg) {
        console.log('[Companion]', 'Service worker registered!');
        window.saved_reg = reg;
        window.register_push_service = utils.register_push_service;
        utils.register_push_service(reg).then(function(){
          window.close();
        });
    })
  }
}

install()
