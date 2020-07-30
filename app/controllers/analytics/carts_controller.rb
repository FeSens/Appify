module Analytics
  class CartsController < AnalyticsController

    def create
      cart = Cart.find_or_initialize_by(token: params[:token])
      cart.update(cart_params)
    end

    def cart_params
      subscriber_id = params[:subscriber_id]
      p = Push.find_by(subscriber_id: subscriber_id)
      params.permit(:token, :hexdigest, :utm_medium, :utm_campaign, :utm_source, data:{}).merge(push_id: p.present? ? p.id : nil, shop_id: shop.id, impacted: params['utm_source']&.include?('aplicatify'))
    end
  end
end