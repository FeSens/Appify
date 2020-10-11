require "rails_helper"

RSpec.describe "Analytics::Campaigns", type: :request do
  let(:campaign) { FactoryBot.create :campaign }

  shared_examples "http_status" do
    before { post "/analytics/campaigns", params: params }

    it { expect(response).to have_http_status(status) }
  end

  describe "increment impressions" do
    let(:params) { { campaign_id: campaign.id, attr: "impressions" } }
    let(:status) { :no_content }

    include_examples "http_status"
  end

  describe "increment clicks" do
    let(:params) { { campaign_id: campaign.id, attr: "clicks" } }
    let(:status) { :no_content }

    include_examples "http_status"
  end

  describe "increment wrong property" do
    let(:params) { { campaign_id: campaign.id, attr: "rubish" } }
    let(:status) { :unprocessable_entity }

    include_examples "http_status"
  end
end
