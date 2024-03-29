# frozen_string_literal: true

module Admin
  class AuthenticatedController < ApplicationController
    layout "authenticated"

    rescue_from ActiveResource::UnauthorizedAccess, with: :logout_on_failure
    rescue_from NoMethodError, with: :logout_on_failure
    rescue_from StandardError, with: :logout_on_failure
    #include ShopifyApp::Authenticated #if Rails.env.production?
    before_action :save_login_params
    before_action :authenticate_user!

    helper_method :current_shop
    before_action :set_locale
    before_action :verify_billing_plan, only: %i[index] #if Rails.env.production?
    after_action :set_activity, only: %i[index]

    private

    def current_shop
      @current_shop ||= begin
        current_user.shop
      end
    end

    def set_activity
      current_shop.touch(:last_activity)
    end

    def set_locale
      I18n.locale = "pt-BR" # current_shop.locale if I18n.available_locales.include? current_shop.locale.to_sym
    end

    def verify_billing_plan
      if current_shop.id == 55 && Flipper['extra-use'].enabled?(current_shop)
        raise StandardError, "A sua loja excedeu os limites de uso. Por favor contate o nosso time de suporte"
      end

      return if current_shop.plan.present? && current_shop.active
      # return if current_shop.shopify_domain == "teste-giovanna.myshopify.com" # TODO: Put a flipper on it
      return unless current_shop.type == "Shop::Shopify"
      # TODO: Refactor Plans::Creator to take shop type in to account
      plan = Plan.find(1)
      result = Plans::Creator.call(plan, current_shop, callback_admin_plans_url)
      return redirect_to result.success if result.success?

      flash[:danger] = result.failure
      redirect_to admin_plans_path
    end

    def logout_on_failure(exception=nil)
      flash[:error] = exception.message if exception.present?
      sign_out current_user
      redirect_to new_user_session_path
    end
  end
end
