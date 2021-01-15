require "rails_helper"

describe Plans::Creator do
  let(:shop) { FactoryBot.create :shop }
  let(:plan) { FactoryBot.create :plan }

  describe "link push subscribers to the campaign" do
    it { expect(Plans::Creator.call(plan, shop, "https://www.lvh.me/test")).to eq(1) }
  end
end
