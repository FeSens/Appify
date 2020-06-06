module Admin
  class PlansController < AuthenticatedController
    def index; end

    def create
      @recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new(
        name: 'Gift Basket Plan',
        price: 9.99,
        return_url: callback_admin_plans_path,
        test: true,
        trial_days: 7,
        capped_amount: 100,
        terms: '$0.99 for every order created'
      )

      
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

    def plan(id)
      @plan = Plan.find(id).slice(:name, :price, :return_url, :trial_days, :capped_amount, :terms)
    end
  end
end
