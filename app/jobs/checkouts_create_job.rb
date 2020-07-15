class CheckoutsCreateJob < ActiveJob::Base
  class CartNotFoundError < StandardError ; end
  queue_as :low
  attr_accessor :webhook
  def perform(shop_domain:, webhook:)
    @webhook = webhook
    cart = Cart.find_by(token: webhook[:cart_token])
    cart.update(abandoned: false) if cart
    raise CartNotFoundError unless cart
  end
end
