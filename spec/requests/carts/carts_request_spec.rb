require "rails_helper"

RSpec.describe "Analytics::Carts", type: :request do
  before { FactoryBot.create(:shop) }

  before { post "/analytics/carts", params: params }

  let(:campaign) { FactoryBot.create :campaign }
  let(:push) { FactoryBot.create :push }
  let(:status) { :no_content }

  shared_examples "http_status" do
    it { expect(response).to have_http_status(status) }
    it { expect(Cart.count).to eq(1) }
  end

  describe "with push subscriber" do
    let(:params) do
      {
        subscriber_id: push.subscriber_id,
        token: rand(36**64).to_s(36),
        hexdigest: rand(36**64).to_s(36),
        utm_medium: "push",
        utm_campaign: "test",
        utm_source: "aplicatify",
        data: { a: "aaa", b: "bbb" }
      }
    end

    include_examples "http_status"
  end

  describe "without push subscriber" do
    let(:params) do
      {
        subscriber_id: nil,
        token: rand(36**64).to_s(36),
        hexdigest: rand(36**64).to_s(36),
        utm_medium: "push",
        utm_campaign: "test",
        utm_source: "aplicatify",
        data: { a: "aaa", b: "bbb" }
      }
    end

    include_examples "http_status"
  end
end
