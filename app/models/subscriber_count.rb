class SubscriberCount < ApplicationRecord
  belongs_to :shop
  enum service: %i[pwa push]
  scope :last_month, -> { where('created_at > ?', 30.days.ago) }
  scope :last_half, -> { where('created_at > ?', 14.days.ago) }
end
