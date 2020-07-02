class CheckoutsCreateJob < ActiveJob::Base
  queue_as :low
  attr_accessor :webhook
  def perform(shop_domain:, webhook:)
    @webhook = webhook
    cart = Cart.find_by(token: webhook.cart_token)
    cart.update(abandoned: false) if cart
  end
end
