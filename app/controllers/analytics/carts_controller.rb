module Analytics
  class CartsController < AnalyticsController

    def create
      cart = Cart.find_or_initialize_by(token: params[:token])
      cart.update(cart_params)
    end

    def cart_params
      subscriber_id = params[:subscriber_id]
      p = Push.find_by(subscriber_id: subscriber_id)
      params.permit(:token, :hash, data:{}).merge(push_id: p.present? ? p.id : nil, shop_id: shop.id)
    end
  end
end