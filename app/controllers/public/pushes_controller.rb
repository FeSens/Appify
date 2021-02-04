module Public
  class PushesController < PublicController
    def create
      push_subscriber = Push.find_or_initialize_by(subscriber_id: subscription_params[:subscriber_id]) do |_p|
        SubscriberCount.find_or_create_by(shop_id: shop.id, date: Date.today, service: "push").increment
      end
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
