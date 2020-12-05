module Admin
  class PlansController < AuthenticatedController
    skip_before_action :verify_billing_plan
    def index
      @plans = Plan.all.order(:id).reject{ |u| u.name == "Influencer" }
      @plans = Plan.all if Flipper['influencer'].enabled?(current_shop)
      activated_plan = Rails.env.development? ? Plan.last : ShopifyAPI::RecurringApplicationCharge.current
      @current_plan = Plan.find_by(name: activated_plan&.name)
    end

    def create
      @recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new(plan_params)
      @recurring_application_charge.test = false
      @recurring_application_charge.return_url = callback_admin_plans_url

      return fullpage_redirect_to @recurring_application_charge.confirmation_url if @recurring_application_charge.save

      flash[:danger] = @recurring_application_charge.errors.full_messages.first.to_s.capitalize
      redirect_to admin_plans_path
    end

    def callback
      @recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.find(params[:charge_id])
      flash[:success] =  I18n.t("activerecord.successful.messages.not_saved", model: Plan.model_name.human)
      if @recurring_application_charge.status == "accepted"
        update_shop_limit
        @recurring_application_charge.activate
        flash[:success] = I18n.t("activerecord.successful.messages.updated", model: Plan.model_name.human)
      end

      redirect_to admin_plans_path
    end

    def update_shop_limit
      plan = Plan.find_by(name: @recurring_application_charge.name)
      current_shop.update(push_limit: plan.push_limit, plan_name: 1, plan_id: plan.id)
    end

    private

    def plan_params
      plan = Plan.find(params[:id]).slice(:name, :price, :trial_days)
      plan["trial_days"] = [plan["trial_days"] - shop_age, 0].max
      plan
    end

    def shop_age
      (Time.zone.now - current_shop.created_at).to_i / 1.day
    end
  end
end
