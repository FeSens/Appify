require 'rails_helper'

describe Campaigns::Creator do
  let(:shop) { FactoryBot.create :shop}
  let(:campaign) { FactoryBot.create :campaign, shop: shop }
  let(:targeter) { :all }
  
  describe "link push subscribers to the campaign" do
    before { FactoryBot.create_list :push, 3, shop: shop }
    it { expect {described_class.call(campaign, targeter) }.to change { campaign.pushes.count }.by(3) }
  end

  describe "link only one time" do
    before do 
      FactoryBot.create_list :push, 3, shop: shop 
      described_class.call(campaign, targeter)
    end

    it { expect {described_class.call(campaign, targeter) }.not_to change { PushSubscriberCampaign.count } }
  end
end
