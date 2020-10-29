require "rails_helper"

RSpec.describe AutomaticCampaign, type: :model do
  describe "validations" do
    it { is_expected.to belong_to(:shop).optional(false) }
    it { is_expected.to have_many(:campaigns) }
    it { is_expected.to have_many(:orders) }
    it { is_expected.to validate_presence_of(:type) }
    it { is_expected.to validate_inclusion_of(:type).in_array(AutomaticCampaign::TYPES) }
  end

  context "when having associated campaigns" do
    subject { automatic_campaign.reload }

    let(:automatic_campaign) { FactoryBot.create(:automatic_campaign) }
    let(:n_campaigns) { 2 }
    let(:impressions) { 100 }
    let(:clicks) { 10 }

    before do
      FactoryBot.create_list(:campaign,
                             n_campaigns,
                             automatic_campaign_id: automatic_campaign.id,
                             clicks: clicks / n_campaigns,
                             impressions: impressions / n_campaigns)
    end

    describe ".clicks" do
      it { expect(subject.clicks).to eq(clicks) }
    end

    describe ".impressions" do
      it { expect(subject.impressions).to eq(impressions) }
    end
  end
end
