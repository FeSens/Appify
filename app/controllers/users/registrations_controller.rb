module Users 
  class RegistrationsController < Devise::RegistrationsController
    class LoginError < StandardError; end

    before_action :configure_permitted_parameters
    def create
      # TODO: Make everything run insede a transaction. 
      ActiveRecord::Base.transaction do
        super
        raise LoginError unless @user.errors.blank?

        shop = Shops::Creator.call(auth, {})
        raise LoginError unless shop.success

        @user.update(shop: shop.success)
      end
    rescue LoginError => e
      flash[:error] = shop.failure 
      redirect_to new_user_session_path
    end

    private

    def auth
      params.require(:user).permit(:name, :domain, :provider)
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, 
                                                         :password, 
                                                         :password_confirmation, 
                                                         :name, 
                                                         :domain, 
                                                         :provider])
    end
  end
end