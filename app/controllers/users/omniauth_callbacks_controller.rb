class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include ShopifyApp::LoginProtection
  rescue_from ActiveRecord::RecordInvalid, with: :on_login_error
  rescue_from ActiveResource::UnauthorizedAccess, with: :on_login_error


  def shopify
    result = Shops::Creator.call(auth, session)
    shop = result.success if result.success?
    user = Shopify::AuthUser.call(auth, shop)
    
    sign_in_and_redirect user, event: :authentication
    set_flash_message(:notice, :success, kind: "Shopify") if is_navigational_format?
  end

  def nuvemshop
    result = Shops::Creator.call(auth, session)
    shop = result.success if result.success?
    user = Nuvemshop::AuthUser.call(auth, shop)
    sign_in_and_redirect user, event: :authentication
    set_flash_message(:notice, :success, kind: "Nuvemshop") if is_navigational_format?
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

  def on_login_error(exception=nil)
    flash[:error] = exception.message if exception.present?
    session['shopify.omniauth_params'] = nil
    redirect_to new_user_session_path
  end
end