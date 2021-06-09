class Campaign < ApplicationRecord
  include CachedCountable

  cache_time 10.seconds

  belongs_to :shop
  has_many :push_subscriber_campaigns
  has_many :pushes, through: :push_subscriber_campaigns
  has_many :orders, dependent: :nullify
  
  has_one_attached :image

  scope :last_month, -> { where("created_at > ?", 30.days.ago) }
  scope :released_this_week, -> { where("release_date > ?", 7.days.ago) }
  scope :released_last_week, -> { where("release_date > ? and release_date < ?", 14.days.ago, 7.days.ago) }

  scope :sent, -> { where(arel_table[:release_date].lt(Time.now)) }

  def ctr
    return ((clicks / impressions.to_f) * 100).round(2) if impressions > 0

    0
  end

  def sent?
    impressions != 0
  end
end
