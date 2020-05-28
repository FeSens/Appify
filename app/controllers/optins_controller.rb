class OptinsController < AuthenticatedController
  before_action :validate, only: %i[update]
  def index
    @optin = Optin.find_or_create_by(shop_id: shop.id, kind: 'pwa')
  end

  def update
    Optin.update(optin_params)
    flash[:success] = "Updated with success"
    redirect_to optins_path
  end

  private

  def optin_params
    params.require(:optin).permit(:title, :body, :accept_button, :decline_button,
                                   :background_color, :text_color, :timer, :enabled)
  end

  def validate
    return if Optin.find_by(id: params[:id])&.shop_id == shop.id
    flash[:alert] = "Not Authorized"
    redirect_to optins_path 
  end
end
