module Admin
  class PlansController < AuthenticatedController
    def index
      @plans = Plan.all
    end

    def create
      @recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new(plan)
      @recurring_application_charge.test = true
      @recurring_application_charge.return_url = callback_admin_plans_url

      
      return fullpage_redirect_to @recurring_application_charge.confirmation_url if @recurring_application_charge.save
      
      flash[:danger] = @recurring_application_charge.errors.full_messages.first.to_s.capitalize
      redirect_to admin_plans_path
    end

    def callback
      @recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.find(params[:charge_id])
      if @recurring_application_charge.status == 'accepted'
        @recurring_application_charge.activate
      end
      
      flash[:success] = 'Plan updated successfully'
      redirect_to admin_campaigns_path
    end

    def plan
      @plan = Plan.find(params[:id]).slice(:name, :price, :trial_days, :capped_amount, :terms)
    end
  end
end
