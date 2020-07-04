module Public
  class PublicController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :validate
    attr_accessor :shop

    def validate
      return @shop = Shop.last if Rails.env.development?

      @shop = Shop.find_by(shopify_domain: params[:shop])
      return head :no_content unless shop
    end
  end
end
