module Shops
  class Devise < ApplicationUseCase
    attr_reader :auth, :session

    def initialize(auth, session)
      @auth = auth
      @session = session
    end

    def call
      create_shop
    end

    private

    def create_shop
      Shop::Devise.create(shop_params)
    end

    def shop_params
      auth.slice(:name, :domain)
    end

  end
end