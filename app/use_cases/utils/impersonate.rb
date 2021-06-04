module Utils
  class Impersonate < ApplicationUseCase
    attr_accessor :user, :shop_id

    def initialize(shop_id:, user_id: 144)
      @shop_id = shop_id
      @user = User.find(user_id)
    end

    def call
      user.shop_id = shop_id
      return Success(shop) if user.save
      
      Failure(user.errors.full_messages.first.to_s.capitalize)
    end
  end
end