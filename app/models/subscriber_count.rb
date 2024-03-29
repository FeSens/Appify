class SubscriberCount < ApplicationRecord
  belongs_to :shop
  enum service: { pwa: 0, push: 1, push_unsubscribed: 2 }
  scope :last_month, -> { where("created_at > ?", 30.days.ago) }
  scope :last_half, -> { where("created_at > ?", 14.days.ago) }

  def increment
    SubscriberCount.increment_counter :count, id
  end
end
