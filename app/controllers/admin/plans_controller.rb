module Admin
  class PlansController < AuthenticatedController
    skip_before_action :verify_billing_plan if Rails.env.production?

    def index
      @plans = available_plans
      @current_plan = current_shop.plan
    end

    def create
      response = Plans::Creator.call(plan, current_shop, callback_admin_plans_url)
      return redirect_to response.success if response.success?

      flash[:danger] = response.failure
      redirect_to admin_plans_path
    end

    def callback
      response = Plans::Verifier.call(params[:charge_id], current_shop)
      flash[:success] = response.success if response.success?
      flash[:warning] = response.failure if response.failure?

      return redirect_to admin_home_index_path if response.success
      redirect_to admin_plans_path
    end

    private

    def plan
      Plan.find(params[:id])
    end

    def available_plans
      Plan.all.order(:id).select do |u|
        Flipper[u.name].enabled?(current_shop) || 
        ["Intermediário", "Avançado", "Iniciante"].include?(u.name)
      end
    end
  end
end
