module Analytics
  class OptInsController < AnalyticsController
    attr_accessor :opt_in_count

    def create
      opt_in_count.increment(params[:attr])

      head :no_content
    end

    private

    def opt_in_params
      params.permit(:service).merge(shop_id: shop.id, date: Date.today.at_beginning_of_month)
    end

    def opt_in_count
      @opt_in_count ||= Rails.cache.fetch("Analytics/OptInsController/#{shop.id}/#{params[:service]}", expires_in: 5.minutes) do
        OptInCount.find_or_create_by(opt_in_params)
      end
    end
  end
end