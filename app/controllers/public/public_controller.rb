module Public
  class PublicController < ActionController::Base
    skip_before_action :verify_authenticity_token
    before_action :validate
    attr_accessor :shop

    def validate
      return @shop = Shop.last if Rails.env.development?

      @shop = Shop.find_by(domain: request.host)
      render :no_content unless shop
    end
  end
end
