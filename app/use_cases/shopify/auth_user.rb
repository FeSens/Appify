module Shopify
  class AuthUser < ApplicationUseCase
    attr_reader :uid, :credentials, :shop

    def initialize(auth, shop)
      @uid = auth['uid']
      @credentials = auth['credentials']
      @shop = shop
    end

    def call
      User.create_with(uid: uid, credentials: credentials).find_or_create_by!(email: email)
    end
  end
end