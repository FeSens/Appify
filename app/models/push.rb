class Push < ApplicationRecord
  belongs_to :customer, optional: true
  belongs_to :shop, optional: true
  has_many :push_subscriber_campaigns
  has_many :campaigns, through: :push_subscriber_campaigns
  scope :last_month, -> { where('created_at > ?', 30.days.ago) }
  scope :last_half, -> { where('created_at > ?', 14.days.ago) }
  scope :active, -> { where('updated_at > ?', 12.hours.ago) }
end
