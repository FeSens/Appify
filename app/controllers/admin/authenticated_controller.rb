# frozen_string_literal: true

module Admin
  class AuthenticatedController < ApplicationController
    include ShopifyApp::Authenticated if Rails.env.production?

    helper_method :current_shop
    before_action :set_locale
    after_action :set_activity, only: %i[index]
    before_action :verify_billing_plan, only: %i[index] if Rails.env.production?

    private

    def current_shop
      @current_shop ||= begin
        return Shop.last unless Rails.env.production?

        Shop.find(session[:shop_id])
      end
    end

    def set_activity
      current_shop.touch(:last_activity)
    end

    def set_locale
      I18n.locale = "pt-BR"#current_shop.locale if I18n.available_locales.include? current_shop.locale.to_sym
    end

    def verify_billing_plan
      return unless current_shop.plan_name == "partner_test"
      return if current_shop.shopify_domain == "teste-giovanna.myshopify.com"

      @recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new(plan_params)
      @recurring_application_charge.test = false
      @recurring_application_charge.return_url = callback_admin_plans_url

      return fullpage_redirect_to @recurring_application_charge.confirmation_url if @recurring_application_charge.save

      flash[:danger] = @recurring_application_charge.errors.full_messages.first.to_s.capitalize
      redirect_to admin_plans_path
    end

    def plan_params
      Plan.find(1).slice(:name, :price, :trial_days)
    end
  end
end
