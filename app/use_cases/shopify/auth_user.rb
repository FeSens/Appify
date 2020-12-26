module Shopify
  class AuthUser < ApplicationUseCase
    attr_reader :uid, :credentials, :shop

    def initialize(auth, shop)
      @uid = auth['uid']
      @credentials = auth['credentials']
      @shop = shop
    end

    def call
      shop.with_shopify_session do
        @shop_data = ShopifyAPI::Shop.current
      end
      User.last#.create_with(uid: uid, credentials: credentials, shop_id: shop.id).find_or_create_by!(email: shop_email)
    end

    private

    def shop_email
      shop_data.email
    end

    def shop_data
      shop_data ||= begin 
        shop.with_shopify_session do
          @shop_data = ShopifyAPI::Shop.current
        end
      end
    end
  end
end