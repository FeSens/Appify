module Public
  class PublicController < ActionController::Base
    skip_before_action :verify_authenticity_token
    skip_after_action :intercom_rails_auto_include
    before_action :validate, only: %i[index]
    attr_accessor :shop

    def validate
      #return @shop = Shop.last if Rails.env.development?

      @shop = Rails.cache.fetch("Public/PublicController/#{params[:shop]}/#{params[:h]}", expires_in: 60.seconds) do
        return Shop.find(params[:h]) if params[:h].present?

        Shop.find_by(shopify_domain: params[:shop])
      end

      return head :no_content unless shop
    end
  end
end
