module Public
  class PublicController < ActionController::Base
    skip_before_action :verify_authenticity_token
    skip_after_action :intercom_rails_auto_include
    before_action :validate
    attr_accessor :shop

    def validate
      @shop = Rails.cache.fetch("Public/PublicController/#{params[:shop]}}", expires_in: 60.seconds) do
        Shop.find_by(shopify_domain: params[:shop])
      end

      return head :no_content unless shop
    end
  end
end
