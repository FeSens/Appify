module Shops
  class Shopify < ApplicationUseCase
    attr_reader :auth, :session

    def initialize(auth, session)
      @auth = auth
      @session = session
    end

    def call
      return Shop.find(session[:shop_id])
    end

    private

    def create_shop
      "Shops::#{auth['provider']}".constantize.call(auth)
    end

    def token
      auth.dig("credentials", "token")
    end

    def shopify_domain
      auth["uid"]
    end

    def shopify_session
      shopify_session ||= ShopifyAPI::Session.new(
        domain: shopify_domain,
        token: token,
        api_version: ShopifyApp.configuration.api_version
      )
    end
  end
end