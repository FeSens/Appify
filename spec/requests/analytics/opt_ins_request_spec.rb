require "rails_helper"

RSpec.describe "Analytics::OptIns", type: :request do
  let(:shop) { FactoryBot.create :shop}

  shared_examples "http_status" do
    before { post "/analytics/opt_ins", params: params }

    it { expect(response).to have_http_status(status) }
  end

  describe "increment count" do
    let(:params) { { shop_id: shop.id, service: "push", attr: "count" } }
    let(:status) { :no_content }

    include_examples "http_status"
  end
end
