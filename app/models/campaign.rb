class Campaign < ApplicationRecord
  belongs_to :shop
  has_many :push_subscriber_campaigns
  has_many :pushes, through: :push_subscriber_campaigns
end
