module Public
  class PublicController < ActionController::Base
    skip_before_action :verify_authenticity_token
    skip_after_action :intercom_rails_auto_include

    def shop
      @shop ||= Rails.cache.fetch("Public/PublicController/#{params[:shop]}/#{params[:id]}/#{params[:shop_id]}}", expires_in: 60.seconds) do
          return Shop.find(params[:id]) if params[:id].present?
          return Shop.find(params[:shop_id]) if params[:shop_id].present?

          Shop.find_by(shopify_domain: params[:shop])
      end
    end
  end
end
