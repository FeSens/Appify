require "rails_helper"

RSpec.describe "Home", type: :feature do
  let(:subscriber_count) { 3 }

  it "Render Dash Board" do
    shop = FactoryBot.create :shop
    FactoryBot.create_list :push, subscriber_count, shop: shop
    push_interaction = FactoryBot.create :push_interaction, shop: shop
    visit admin_home_index_path

    expect(page).to have_text(push_interaction.count)
    expect(page).to have_text(subscriber_count)
  end
end
