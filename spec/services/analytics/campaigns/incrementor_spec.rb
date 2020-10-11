require "rails_helper"

describe Analytics::Campaigns::Incrementor do
  let(:shop) { FactoryBot.create :shop }
  let(:campaign) { FactoryBot.create :campaign, shop: shop }
  let(:push_interaction) { FactoryBot.create :push_interaction, shop: shop }
  let(:other_push_interaction) { FactoryBot.create :push_interaction }

  describe "increment clicks" do
    it { expect { described_class.call(campaign.shop_id, campaign.id,  "clicks") }.to change { Campaign.find(campaign.id).clicks }.by(1) }
  end

  describe "increment impressions" do
    it { expect { described_class.call(campaign.shop_id, campaign.id,  "impressions") }.to change { Campaign.find(campaign.id).impressions }.by(1) }
    it { expect { described_class.call(campaign.shop_id, campaign.id,  "impressions") }.to change { PushInteraction.find(push_interaction.id).count }.by(1) }
    it { expect { described_class.call(campaign.shop_id, campaign.id,  "impressions") }.not_to(change { PushInteraction.find(other_push_interaction.id).count }) }
  end
end
