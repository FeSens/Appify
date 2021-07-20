module Shops
  class Creator < ApplicationUseCase
    attr_reader :auth, :session

    def initialize(auth, session)
      @auth = auth
      @session = session
    end

    def call
      shop = create_shop
      return Failure("Infelizmente não estamos aceitando novos clientes no  momento")
      return Success(shop) if shop.persisted?

      Failure(shop.errors.full_messages.first.to_s.capitalize)
    end

    private

    def create_shop
      "Shops::#{auth['provider'].classify}".constantize.call(auth, session)
    end

  end
end