module Public
  class JsController < PublicController
    def index
      @optins = Rails.cache.fetch("public/jscontroller/#{shop.id}", expires_in: 5.seconds) do
        pwa  = Optin.find_by(shop_id: shop.id, kind: "pwa")
        push = Optin.find_by(shop_id: shop.id, kind: "push")
        { pwa: pwa, push: push }
      end
      @current_shop = shop
    end

    def show
      @optins = Rails.cache.fetch("public/jscontroller/#{params[:id]}", expires_in: 5.seconds) do
        pwa  = Optin.find_by(shop_id: params[:id], kind: "pwa")
        push = Optin.find_by(shop_id: params[:id], kind: "push")
        { pwa: pwa, push: push }
      end
      @current_shop = Shop.find(params[:id])
    end
  end
end
