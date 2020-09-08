module Admin
  class OptinsController < AuthenticatedController
    before_action :load_optin, only: %i[update]
    attr_accessor :optin

    def index
      pwa  = current_shop.optins.pwa.first
      push = current_shop.optins.push.first
      @optins = { pwa: pwa, push: push }
    end

    def update
      optin.update(optin_params)
      flash[:success] = 'Updated with success'
      redirect_to admin_optins_path(tab: optin.kind)
    end

    private

    def optin_params
      params.require(:optin).permit(:title, :body, :accept_button, :decline_button,
                                    :background_color, :text_color, :timer, :enabled)
    end

    def load_optin
      @optin = current_shop.optins.find(params[:id])
    end
  end
end
