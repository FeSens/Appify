module Admin
  class PlansController < AuthenticatedController
    def index; end

    def create
      recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new(
        name: 'Gift Basket Plan',
        price: 9.99,
        return_url: admin_campaigns_url,
        test: true,
        trial_days: 7,
        capped_amount: 100,
        terms: '$0.99 for every order created'
      )

      return unless recurring_application_charge.save

      fullpage_redirect_to recurring_application_charge.confirmation_url
    end

    def plan(id)
      @plan = Plan.find(id).slice(:name, :price, :return_url, :trial_days, :capped_amount, :terms)
    end
  end
end
