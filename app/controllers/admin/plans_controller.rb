module Admin
  class PlansController < AuthenticatedController
    def index
      @plans = Plan.all
      activated_plan = Rails.env.development? ? Plan.last : ShopifyAPI::RecurringApplicationCharge.current
      @current_plan = Plan.find_by(name: activated_plan&.name)
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
      flash[:success] = 'Your plan was not altered'
      if @recurring_application_charge.status == 'accepted'
        update_shop_limit
        @recurring_application_charge.activate
        flash[:success] = 'Plan updated successfully'
      end
      
      redirect_to admin_plans_path
    end

    def plan
      @plan = Plan.find(params[:id]).slice(:name, :price, :trial_days, :capped_amount, :terms)
    end

    def update_shop_limit
      p = Plan.find_by(name: @recurring_application_charge.name)
      shop.update(push_limit: p.push_limit) 
    end
  end
end
