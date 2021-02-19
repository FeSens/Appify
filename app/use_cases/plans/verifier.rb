module Plans
  class Verifier < ApplicationUseCase
    attr_reader :charge_id, :current_shop
    attr_accessor :plan

    def initialize(charge_id, current_shop)
      @charge_id = charge_id
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
      internal_plan = Plan.find_by(name: plan.name)
      current_shop.update(push_limit: internal_plan.push_limit, plan_id: internal_plan.id, active: true)
    end
  end
end