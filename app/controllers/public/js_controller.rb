module Public
  class JsController < PublicController
    skip_before_action :verify_authenticity_token

    def index
      pwa  = Optin.find_by(shop_id: shop.id, kind: 'pwa')
      push = Optin.find_by(shop_id: shop.id, kind: 'push')
      @optins = { pwa: pwa, push: push }
    end
  end
end