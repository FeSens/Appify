module Plans
  class Verifier < ApplicationUseCase
    attr_reader :charge_id, :current_shop, :plan

    def initialize(charge_id, current_shop)
      @charge_id = plan
      @current_shop = current_shop
    end

    def call
      current_shop.with_shopify_session do
        @plan = ShopifyAPI::RecurringApplicationCharge.find(charge_id)
        if plan.status == "accepted"
          update_shop_limit
          plan.activate
          return Success(I18n.t("activerecord.successful.messages.updated", model: Plan.model_name.human))
        end
      end

      Failure(I18n.t("activerecord.successful.messages.not_saved", model: Plan.model_name.human))
    end

    private

    def update_shop_limit
      plan = Plan.find_by(name: plan.name)
      current_shop.update(push_limit: plan.push_limit, plan_name: 1, plan_id: plan.id)
    end
  end
end