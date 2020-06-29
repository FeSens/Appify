module Analytics
  class SubscribersController < AnalyticsController
    def create
      subscriber_count = SubscriberCount.find_or_create_by(subscriber_params).increment
      head :no_content
    end

    private

    def subscriber_params
      s = Shop.find_by(shopify_domain: params[:shop])
      params.permit(:service).merge(shop_id: s.id, date: Date.today)
    end
  end
end
