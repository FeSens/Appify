class PushInteraction < ApplicationRecord
  include CachedCountable

  class OutOfPushInteractionsError < StandardError; end
  belongs_to :shop

  def available?
    return true if Shop.find(shop_id).push_limit >= count

    false
  end

  def autorized?
    with_lock do
      raise OutOfPushInteractionsError, "shop_id: #{shop_id} is out of interactions" unless available?

      increment
    end
  end
end
