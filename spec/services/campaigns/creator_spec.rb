require 'rails_helper'

describe Campaigns::Creator do
  let(:shop) { FactoryBot.create :shop}
  let(:campaign) { FactoryBot.create :campaign, shop: shop }
  let(:targeter) { :all }
  
  describe "link push subscribers to the campaign" do
    before { FactoryBot.create_list :push, 3, shop: shop }
    it { expect {described_class.call(campaign, targeter) }.to change { campaign.pushes.count }.by(3) }
  end
end
