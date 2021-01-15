# frozen_string_literal: true

module Admin
  class AuthenticatedController < ApplicationController
    layout "authenticated"
    #include ShopifyApp::Authenticated #if Rails.env.production?
    before_action :authenticate_user!
    before_action :save_login_params

    helper_method :current_shop
    before_action :set_locale
    before_action :verify_billing_plan, only: %i[index] if Rails.env.production?
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
      return if current_shop.plan.present?
      return if current_shop.shopify_domain == "teste-giovanna.myshopify.com" # TODO: Put a flipper on it
      return unless current_shop.type == "Shop::Shopify"
      # TODO: Refactor Plans::Creator to take shop type in to account

      plan = Plan.find(1)
      result = Plans::Creator.call(plan, current_shop, callback_admin_plans_url)
      return fullpage_redirect_to result.success if result.success?

      flash[:danger] = result.failure
      redirect_to admin_plans_path
    end
  end
end
