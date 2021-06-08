class OptInCount < ApplicationRecord
  include Countable

  belongs_to :shop
  enum service: { pwa: 0, push: 1 }

  def increment
    OptInCount.increment_counter :count, id
  end
end
