class OptinsController < AuthenticatedController
  before_action :load_optin, only: %i[update]
  def index
    pwa  = Optin.find_or_create_by(shop_id: shop.id, kind: 'pwa')
    push = Optin.find_or_create_by(shop_id: shop.id, kind: 'push')
    @optins = { pwa: pwa, push: push }
  end

  def update
    @optin.update(optin_params)
    flash[:success] = "Updated with success"
    redirect_to optins_path(tab: @optin.kind)
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
