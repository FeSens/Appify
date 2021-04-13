require "rails_helper"

describe Campaigns::Targeters::All do
  let(:shop) { FactoryBot.create :shop }
  let(:pushes) { FactoryBot.create_list :push, 3, shop: shop }
  let(:other_pushes) { FactoryBot.create_list :push, 3 }

  describe "return all pushes from pushes list" do
    it { expect(described_class.call(shop.id)).to match_array(pushes) }
  end

  describe "return only pushes available to itself" do
    it { expect(described_class.call(shop.id)).not_to match_array(other_pushes) }
  end
end
