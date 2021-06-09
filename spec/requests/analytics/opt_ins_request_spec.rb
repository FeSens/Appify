require "rails_helper"

RSpec.describe "Analytics::OptIns", type: :request do
  let(:shop) { FactoryBot.create :shop}
  let(:params) { { shop_id: shop.id, service: "push", attr: "count" } }
  let(:status) { :no_content }

  shared_examples "http_status" do
    before { post "/analytics/opt_ins", params: params }

    it { expect(response).to have_http_status(status) }
  end

  describe "increment count" do
    include_examples "http_status"

    it { expect { post "/analytics/opt_ins", params: params }.to change { OptInCount.count }.by(1) }
  end
end
