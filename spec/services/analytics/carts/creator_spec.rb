require 'rails_helper'

describe Analytics::Carts::Creator do
  let(:shop) { FactoryBot.create :shop}
  let(:campaign) { FactoryBot.create :campaign, shop: shop }
  let(:push) { FactoryBot.create :push}
  let(:params) do
    { 
      token: rand(36**64).to_s(36),
      hexdigest: rand(36**64).to_s(36),
      utm_medium: "push",
      utm_campaign: "test",
      utm_source: "aplicatify",
      data: "{'a': 'aaa', 'b': 'bbb' }"
    }
  end

  let(:params_without_aplicatify) do
    { 
      token: params[:token],
      hexdigest: rand(36**64).to_s(36),
      utm_medium: "push",
      utm_campaign: "test",
      utm_source: "other source",
      data: "{'a': 'aaa', 'b': 'bbb' }"
    }
  end

  shared_examples "call" do
    it { expect {described_class.call(params, push.subscriber_id, shop.id)}.to change { Cart.count }.by(1) }

    it "calls are idempotent" do
      expect do 
        described_class.call(params, push.subscriber_id, shop.id)
        described_class.call(params, push.subscriber_id, shop.id)
      end .to change { Cart.count }.by(1) 
    end
  end

  describe "with push subscriber" do
    let(:push) { FactoryBot.create :push }
    include_examples "call"
  end

  describe "without push subscriber" do
    let(:push) { FactoryBot.create :push, subscriber_id: nil}
    include_examples "call"
  end

  describe "with unexistent push subscriber" do
    let(:push) { FactoryBot.create :push, subscriber_id: 37821318}
    include_examples "call"
  end

  describe "saves cart with impacted = true" do
    it "with the first request including aplicatify in utm_source" do
      described_class.call(params, push.subscriber_id, shop.id)

      expect(Cart.last).to have_attributes(impacted: true)
    end

    it "with the last request including aplicatify in utm_source" do
      described_class.call(params, push.subscriber_id, shop.id)
      described_class.call(params_without_aplicatify, push.subscriber_id, shop.id)

      expect(Cart.last).to have_attributes(impacted: true)
    end
  end

  describe "saves cart with impacted = false" do
    it "without any request including aplicatify" do
      described_class.call(params_without_aplicatify, push.subscriber_id, shop.id)

      expect(Cart.last).to have_attributes(impacted: false)
    end
  end

  describe "saves cart with params" do
    before { described_class.call(params, push.subscriber_id, shop.id) }
    it { expect(Cart.last).to have_attributes(params) }
  end
end
