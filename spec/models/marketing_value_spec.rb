require 'rails_helper'

RSpec.describe MarketingValue, type: :model do
  it { is_expected.to belong_to(:shop).optional(false) }
  it { is_expected.to validate_numericality_of(:cpc) }
  it { is_expected.to validate_numericality_of(:cpd) }
  it { is_expected.to validate_numericality_of(:cps) }
end
