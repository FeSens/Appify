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
      p = auth.slice(:name, :domain)
      p[:domain] = pad_url(p[:domain])
      p
    end

    def pad_url(url)
      u = url.gsub("https://", "").gsub("http://", "")
      "https://#{u}"
    end
  end
end
