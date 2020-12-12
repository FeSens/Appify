module Plans
  class Creator < ApplicationUseCase
    include Rails.application.routes.url_helpers
    attr_reader :plan, :current_shop

    def initialize(plan, current_shop)
      @plan = plan
      @current_shop = current_shop
    end

    def call
      current_shop.with_shopify_session do
        plan = ShopifyAPI::RecurringApplicationCharge.new(plan_params)
        return Success(plan.confirmation_url) if plan.save
      end

      Failure(plan.errors.full_messages.first.to_s.capitalize)
    end

    private

    def plan_params
      params = plan.slice(:name, :price, :trial_days)
      params["trial_days"] = [params["trial_days"] - shop_age, 0].max
      params["test"] = false
      params["return_url"] = callback_admin_plans_url
      params
    end

    def shop_age
      (Time.zone.now - current_shop.created_at).to_i / 1.day
    end
  end
end