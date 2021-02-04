require "rails_helper"

RSpec.describe "Analytics::Campaigns", type: :request do
  let(:shop) { FactoryBot.create :shop}
  let(:campaign) { FactoryBot.create :campaign, shop: shop }

  shared_examples "http_status" do
    before { post "/analytics/campaigns", params: params }

    it { expect(response).to have_http_status(status) }
  end

  describe "increment impressions" do
    let(:params) { { campaign_id: campaign.id, attr: "impressions", shop_id: shop.id } }
    let(:status) { :no_content }

    include_examples "http_status"
  end

  describe "increment clicks" do
    let(:params) { { campaign_id: campaign.id, attr: "clicks", shop_id: shop.id } }
    let(:status) { :no_content }

    include_examples "http_status"
  end

  describe "increment wrong property" do
    let(:params) { { campaign_id: campaign.id, attr: "rubish", shop_id: shop.id } }
    let(:status) { :unprocessable_entity }

    include_examples "http_status"
  end
end
