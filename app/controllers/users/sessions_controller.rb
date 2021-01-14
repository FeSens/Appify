class Users::SessionsController < Devise::SessionsController
  layout "devise"
  include ShopifyApp::LoginProtection

  def new
    session['shopify.omniauth_params'] = { shop: referer_sanitized_shop_name } if  referer_sanitized_shop_name.present?
    session['shopify.omniauth_params'] = { shop: sanitized_shop_name } if sanitized_shop_name.present?
    return redirect_to user_shopify_omniauth_authorize_path if session['shopify.omniauth_params'].present?

    super
  end

  def after_sign_out_path_for(_resource_or_scope)
    admin_home_index_path
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || root_path
  end

  private
  
  def sanitized_shop_name
    @sanitized_shop_name ||= sanitize_shop_param(params)
  end

  def sanitize_shop_param(params)
    return unless params[:shop].present?
    ShopifyApp::Utils.sanitize_shop_domain(params[:shop])
  end

  def auth
    @auth ||= request.env['omniauth.auth']
  end

  
end