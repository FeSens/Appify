class Push < ApplicationRecord
  belongs_to :customer, optional: true
  belongs_to :shop, optional: true
  has_many :push_subscriber_campaigns, dependent: :destroy
  has_many :campaigns, through: :push_subscriber_campaigns
  has_many :page_visits, dependent: :nullify
  has_many :carts, dependent: :nullify
  has_many :checkouts, dependent: :destroy, foreign_key: "subscriber_id", primary_key: "subscriber_id"
  scope :last_month, -> { where("created_at > ?", 30.days.ago) }
  scope :last_half, -> { where("created_at > ?", 14.days.ago) }
  scope :active, -> { where("updated_at > ?", 12.hours.ago) }
end
