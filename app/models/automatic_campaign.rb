class AutomaticCampaign < ApplicationRecord
  TYPES = %w[AutomaticCampaigns::MostSeen].freeze
  belongs_to :shop
  has_many :campaigns
  has_many :orders, through: :campaigns

  store :config, coder: JSON

  validates :type, presence: true
  validates :type, inclusion: { in: TYPES }

  def clicks
    campaigns.pluck(:clicks).sum
  end

  def impressions
    campaigns.pluck(:impressions).sum
  end
end
