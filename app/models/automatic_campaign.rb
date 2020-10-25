class AutomaticCampaign < ApplicationRecord
  TYPES = %w[Test].freeze
  belongs_to :shop
  has_many :campaigns
  has_many :orders, through: :campaigns

  store :config, coder: JSON

  validates :type, presence: true
  validates :type, inclusion: { in: TYPES }
end
