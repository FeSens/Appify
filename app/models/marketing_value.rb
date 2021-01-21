class MarketingValue < ApplicationRecord
  belongs_to :shop

  validates :cpc, numericality: { greater_than_or_equal_to: 0 }
  validates :cps, numericality: { greater_than_or_equal_to: 0 }
  validates :cpd, numericality: { greater_than_or_equal_to: 0 }
end
