class ApplicationController < ActionController::Base

  private

  def save_login_params
    return if current_user.present?

    session['shopify.omniauth_params'] = shopify_omniauth_params if sanitized_shop_name.present?
  end

  def shopify_omniauth_params
    temp = params.permit(:shop, :hmac, :new_design_language, :session, :timestamp).to_h
    temp[:shop] = sanitized_shop_name
    temp
  end

  def sanitized_shop_name
    @sanitized_shop_name ||= sanitize_shop_param(params)
  end

  def sanitize_shop_param(params)
    return unless params[:shop].present?
    ShopifyApp::Utils.sanitize_shop_domain(params[:shop])
  end
end
