class OptInCount < ApplicationRecord
  include Countable

  belongs_to :shop
  enum service: { pwa: 0, push: 1 }
end
