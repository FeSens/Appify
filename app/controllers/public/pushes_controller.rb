module Public
  class PushesController < PublicController
    layout "pushes"
    def new
      @current_shop = Shop.find_by(subdomain: request.subdomain)
    end

    def create
      push_subscriber = Push.find_or_initialize_by(subscriber_id: subscription_params[:subscriber_id])
      push_subscriber = push_subscriber.update(subscription_params)

      return render json: { message: "Subscription Failed" }, status: :unprocessable_entity unless push_subscriber

      render json: { message: "Subscription Succeded" }
    end

    private

    def subscription_params
      params.permit(:subscriber_id, :endpoint, :auth, :p256dh).merge(shop_id: shop.id) if shop.present?
    end
  end
end
