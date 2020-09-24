require "rails_helper"

RSpec.feature "Home", type: :feature do
  let(:subscriber_count) { 3}
  scenario "Render Dash Board" do
    shop = FactoryBot.create :shop
    FactoryBot.create_list :push, subscriber_count, shop: shop
    push_interaction = FactoryBot.create :push_interaction, shop: shop
    visit admin_home_index_path
    
    expect(page).to have_text(push_interaction.count)
    expect(page).to have_text(subscriber_count)
  end
end