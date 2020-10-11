module Analytics
  class CartsController < AnalyticsController
    def create
      Analytics::Carts::Creator.call(cart_params, params[:subscriber_id], shop.id)
      head :no_content
    end

    def cart_params
      params.permit(:token, :hexdigest, :utm_medium, :utm_campaign, :utm_source, data: {})
    end
  end
end
