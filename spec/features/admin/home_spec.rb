require "rails_helper"

RSpec.describe "Home", type: :feature do
  let(:subscriber_count) { 3 }
  let(:user) { FactoryBot.build :user }
  let(:shop) { FactoryBot.build :shop }
  
  before(:each) do
    user.update(shop: shop)
    login_as(user, :scope => :user)
  end

  it "Render Dash Board" do
    FactoryBot.create_list :push, subscriber_count, shop: shop
    push_interaction = FactoryBot.create :push_interaction, shop: shop
    visit admin_home_index_path

    expect(page).to have_text(push_interaction.count)
    expect(page).to have_text(subscriber_count)
  end
end
