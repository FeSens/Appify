module Shopify
  class AuthUser < ApplicationUseCase
    attr_reader :uid, :credentials, :shop

    def initialize(auth, shop)
      @uid = auth['uid']
      @credentials = auth['credentials']
      @shop = shop
    end

    def call
      User.create_with(uid: uid, credentials: credentials, password: password).find_or_create_by!(email: shop_email, shop_id: shop.id)
    end

    private

    def password
      Digest::SHA256.base64digest(shop.shopify_token)
    end

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