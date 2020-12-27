class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include ShopifyApp::LoginProtection

  def shopify
    Shopify::AuthCallback.call(auth, session)
    result = Shops::Creator.call(auth, session)
    shop = result.success if result.success?
    user = Shopify::AuthUser.call(auth, shop)
    
    sign_in_and_redirect user, event: :authentication
  end

  protected

  def after_omniauth_failure_path_for(_scope)
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