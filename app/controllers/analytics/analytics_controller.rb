class Analytics::AnalyticsController < ActionController::API
  skip_after_action :intercom_rails_auto_include
  before_action :find_shop
  attr_accessor :shop

  def find_shop
    return @shop = Shop.last unless Rails.env.production?

    @shop = Rails.cache.fetch("Analytics/AnalyticsController/#{params[:shop]}/#{params[:shop_id]}", expires_in: 60.seconds) do
      return Shop.find(params[:shop_id]) if params[:shop_id].present?

      Shop.find_by(shopify_domain: params[:shop])
    end

    return head :no_content unless shop
  end
end
