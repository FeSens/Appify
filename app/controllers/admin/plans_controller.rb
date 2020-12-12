module Admin
  class PlansController < AuthenticatedController
    skip_before_action :verify_billing_plan if Rails.env.production?

    def index
      @plans = Plan.all.order(:id).reject{ |u| u.name == "Influencer" }
      @plans = Plan.all if Flipper['influencer'].enabled?(current_shop)
      @current_plan = current_shop.plan
    end

    def create
      response = Plans::Creator.call(plan, current_shop)
      return fullpage_redirect_to response.success if response.success?

      flash[:danger] = response.failure
      redirect_to admin_plans_path
    end

    def callback
      response = Plans::Verifier.call(params[:charge_id], current_shop)
      flash[:success] = response.success if response.success?
      flash[:warning] = response.failure if response.failure?

      redirect_to admin_plans_path
    end

    private

    def plan
      Plan.find(params[:id])
    end
  end
end
