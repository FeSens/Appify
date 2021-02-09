module Public
  class CheckoutsController < PublicController
    def create 
      Checkout.create(checkout_params)
      head :no_content
    end
  end

  private

  def checkout_params
    params.permit(:checkout_id, :subscriber_id, :utm_campaign)
  end
end
