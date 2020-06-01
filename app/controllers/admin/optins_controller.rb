module Admin
  class OptinsController < AuthenticatedController
    before_action :load_optin, only: %i[update]
    attr_accessor :optin

    def index
      pwa  = Optin.find_or_create_by(shop_id: shop.id, kind: 'pwa', 
        title: "Put our store in your pocket!", body: "Download our app and keep updated about your order and the newest products!",
        accept_button: "Let's go!", timer: 15)
      push = Optin.find_or_create_by(shop_id: shop.id, kind: 'push')
      @optins = { pwa: pwa, push: push }
    end

    def update
      optin.update(optin_params)
      flash[:success] = "Updated with success"
      redirect_to admin_optins_path(tab: @optin.kind)
    end

    private

    def optin_params
      params.require(:optin).permit(:title, :body, :accept_button, :decline_button,
                                    :background_color, :text_color, :timer, :enabled)
    end

    def load_optin
      @optin = shop.optins.find(params[:id])
    end
  end
end