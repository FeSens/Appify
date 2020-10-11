require "rails_helper"

RSpec.describe "Configure PWA", type: :feature do
  let(:manifest) { FactoryBot.build :manifest }
  let(:manifest_attributes) { manifest.attributes.except("created_at", "id", "updated_at", "shop_id") }

  it "User Configure PWA" do
    shop = FactoryBot.create :shop
    visit edit_admin_pwa_path

    within "form" do
      fill_in "manifest_name", with: manifest.name
      fill_in "manifest_short_name", with: manifest.short_name
      fill_in "manifest_theme_color", with: manifest.theme_color
      fill_in "manifest_background_color", with: manifest.background_color
      fill_in "manifest_description", with: manifest.description
    end

    click_button "Save"

    expect(shop.reload.manifest).to have_attributes manifest_attributes
  end
end
