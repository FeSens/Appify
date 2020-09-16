class Analytics::AnalyticsController < ActionController::API
  before_action :find_shop
  attr_accessor :shop

  def find_shop
    return @shop = Shop.last unless Rails.env.production?

    @shop = Shop.find_by(shopify_domain: params[:shop])
    return head :no_content unless shop
  end
end
