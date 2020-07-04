
module Analytics
  class OptInsController < AnalyticsController

    def create
      OptInCount.find_or_create_by(opt_in_params).increment
      head :no_content
    end

    private

    def opt_in_params
      params.permit(:service).merge(shop_id: shop.id, date: Time.now.beginning_of_hour)
    end
  end
end