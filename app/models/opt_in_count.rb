class OptInCount < ApplicationRecord
  belongs_to :shop
  enum service: { pwa: 0, push: 1 }
  scope :last_hour, -> { where('created_at > ?', 1.hour.ago) }
end
