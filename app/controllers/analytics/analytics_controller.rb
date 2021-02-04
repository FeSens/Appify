class Analytics::AnalyticsController < ActionController::API
  skip_after_action :intercom_rails_auto_include

  def shop
    @shop ||= Rails.cache.fetch("Analytics/AnalyticsController/#{params[:shop]}/#{params[:id]}/#{params[:shop_id]}}", expires_in: 60.seconds) do
      return Shop.find(params[:id]) if params[:id].present?
      return Shop.find(params[:shop_id]) if params[:shop_id].present?

      Shop.find_by(shopify_domain: params[:shop])
    end
  end
end
