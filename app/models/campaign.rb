class Campaign < ApplicationRecord
  belongs_to :shop
  has_many :push_subscriber_campaigns
  has_many :pushes, through: :push_subscriber_campaigns
  has_many :orders, dependent: :nullify

  scope :sent, -> { where(arel_table[:release_date].lt(Time.now)) }

  def ctr
    return ((clicks / impressions.to_f) * 100).to_i if impressions > 0
    0
  end
end
