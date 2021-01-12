require "rails_helper"

RSpec.describe "Configure PWA", type: :feature do
  let(:manifest) { FactoryBot.build :manifest }
  let(:manifest_attributes) { manifest.attributes.except("theme_color", "short_name", "created_at", "id", "updated_at", "shop_id") }
  let(:user) { FactoryBot.build :user }
  let(:shop) { FactoryBot.build :shop }
  
  before(:each) do
    user.update(shop: shop)
    login_as(user, :scope => :user)
  end

  it "User Configure PWA" do
    visit edit_admin_pwa_path

    within "form" do
      fill_in "manifest_name", with: manifest.name
      #fill_in "manifest_short_name", with: manifest.short_name
      #fill_in "manifest_theme_color", with: manifest.theme_color
      fill_in "manifest_background_color", with: manifest.background_color
      #fill_in "manifest_description", with: manifest.description
    end

    click_button "commit"

    expect(shop.reload.manifest).to have_attributes manifest_attributes
  end
end
