require "rails_helper"

RSpec.describe AutomaticCampaign, type: :model do
  describe "validations" do
    it { is_expected.to belong_to(:shop).optional(false) }
    it { is_expected.to have_many(:campaigns) }
    it { is_expected.to have_many(:orders) }
    it { is_expected.to validate_presence_of(:type) }
    it { is_expected.to validate_inclusion_of(:type).in_array(AutomaticCampaign::TYPES) }
  end
end
