class Users::SessionsController < Devise::SessionsController
  layout "devise"
  include ShopifyApp::LoginProtection

  before_action :save_login_params

  def new
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

  def auth
    @auth ||= request.env['omniauth.auth']
  end

  
end