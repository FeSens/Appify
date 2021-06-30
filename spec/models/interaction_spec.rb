require 'rails_helper'

RSpec.describe Interaction, type: :model do
  it { is_expected.to belong_to(:shop).optional(false) }
  it { is_expected.to belong_to(:campaign).optional(true) }
  it { is_expected.to belong_to(:_next).optional(true) }
  it { is_expected.to belong_to(:_prev).optional(true) }

  let(:shop) { FactoryBot.create :shop }
  let(:pushes) { FactoryBot.create_list :push, 3, shop: shop }
  let(:campaign) { FactoryBot.create :campaign, shop: shop }
  let(:next_interaction) { FactoryBot.create :interaction, campaign: campaign, shop: shop }
  let(:prev_interaction) { FactoryBot.create :interaction, campaign: campaign, shop: shop }
  let(:interaction) { FactoryBot.create :interaction, campaign: campaign, shop: shop, _prev: prev_interaction, _next: next_interaction }

  describe "when linking pushes to interaction" do
    before { interaction.pushes << pushes }

    it { expect(interaction.pushes).to match_array(pushes) }
    it { expect(InteractionPushLink.where(interaction: interaction).pluck(:push_id)).to match_array(pushes.pluck(:id)) }
  end

  context "when updating linked list" do
    before { interaction.pushes << pushes }

    describe ".run" do
      it { expect { interaction.run }.to change{interaction.count}.by(pushes.count) }
      it { expect { interaction.run }.to change{interaction.pushes.count}.from(pushes.count).to(0) }
      it { expect { interaction.run }.to change{interaction.pushes.count}.from(pushes.count).to(0) }
    end

    describe "forwards the pushes subscribers to the next interaction" do
      before { interaction.run }

      it { expect(interaction.pushes.count).to eq(0) }
      it { expect(interaction.reload.pushes).not_to match_array(pushes) }
      it { expect(next_interaction.pushes).to match_array(pushes) }
      end

      describe ".destroy" do
        before { interaction.destroy }

        it { expect(prev_interaction._next).to eq(next_interaction) }
        it { expect(next_interaction._prev).to eq(prev_interaction) }
    end
  end
end
