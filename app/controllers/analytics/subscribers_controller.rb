module Analytics
  class SubscribersController < AnalyticsController
    def create
      SubscriberCount.find_or_create_by(subscriber_params).increment
      head :no_content
    end

    private

    def subscriber_params
      params.permit(:service).merge(shop_id: shop.id, date: Date.today)
    end
  end
end
