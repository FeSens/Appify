require 'rails_helper'

RSpec.describe AutomationBlock, type: :model do
  it { is_expected.to belong_to(:shop).optional(false) }
  it { is_expected.to belong_to(:campaign).optional(false) }
  it { is_expected.to belong_to(:_next).optional(true) }
  it { is_expected.to belong_to(:_prev).optional(true) }
  
  let(:shop) { FactoryBot.create :shop }
  let(:pushes) { FactoryBot.create_list :push, 3, shop: shop }
  let(:campaign) { FactoryBot.create :campaign, shop: shop }
  let(:next_block) { FactoryBot.create :automation_block, campaign: campaign, shop: shop }
  let(:prev_block) { FactoryBot.create :automation_block, campaign: campaign, shop: shop }
  let(:block) { FactoryBot.create :automation_block, campaign: campaign, shop: shop, _prev: prev_block, _next: next_block }
  
  describe "when linking pushes to block" do
    before { block.pushes << pushes }

    it { expect(block.pushes).to match_array(pushes) }
    it { expect(AutomationBlockLink.where(automation_block: block).pluck(:push_id)).to match_array(pushes.pluck(:id)) }
  end

  context "when updating linked list" do
    before { block.pushes << pushes }

    describe ".run" do
      it { expect { block.run }.to change{block.count}.by(pushes.count) }
      it { expect { block.run }.to change{block.pushes.count}.from(pushes.count).to(0) }
      it { expect { block.run }.to change{block.pushes.count}.from(pushes.count).to(0) }
    end

    describe "forwards the pushes subscribers to the next block" do
      before { block.run }

      it { expect(block.pushes.count).to eq(0) }
      it { expect(block.reload.pushes).not_to match_array(pushes) }
      it { expect(next_block.pushes).to match_array(pushes) }
    end

    describe ".destroy" do
      before { block.destroy }

      it { expect(prev_block._next).to eq(next_block) }
      it { expect(next_block._prev).to eq(prev_block) }
    end
  end

end
