class CheckoutsCreateJob < ActiveJob::Base
  class CartNotFoundError < StandardError ; end
  queue_as :low
  attr_accessor :webhook
  def perform(shop_domain:, webhook:)
    cart = IdentifyCart.new(webhook).call
    raise CartNotFoundError unless cart
  end
end
