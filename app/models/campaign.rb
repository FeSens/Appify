class Campaign < ApplicationRecord
  belongs_to :shop
  has_many :push_subscriber_campaigns, dependent: :destroy
  has_many :pushes, through: :push_subscriber_campaigns, dependent: :destroy
  scope :sent, -> { where(arel_table[:release_date].lt(Time.now)) }
end
