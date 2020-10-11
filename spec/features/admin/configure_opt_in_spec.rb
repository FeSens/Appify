require "rails_helper"

RSpec.describe "Configure Opt In", type: :feature do
  let(:optin) { FactoryBot.build :optin }
  let(:optin_attributes) { optin.attributes.except("created_at", "id", "updated_at", "shop_id", "kind") }

  it "User Configure Push Opt In" do
    shop = FactoryBot.create :shop
    visit admin_optins_path

    within "form" do
      fill_in "optin_title", with: optin.title
      fill_in "optin_body", with: optin.body
      fill_in "optin_accept_button", with: optin.accept_button
      fill_in "optin_decline_button", with: optin.decline_button
      fill_in "optin_background_color", with: optin.background_color
      fill_in "optin_text_color", with: optin.text_color
      fill_in "optin_timer", with: optin.timer
    end

    click_button "Save"

    expect(shop.reload.optins.push.first).to have_attributes optin_attributes
  end

  it "User Configure Pwa Opt In" do
    shop = FactoryBot.create :shop
    visit admin_optins_path
    click_link "PWA"

    within "form" do
      fill_in "optin_title", with: optin.title
      fill_in "optin_body", with: optin.body
      fill_in "optin_accept_button", with: optin.accept_button
      fill_in "optin_decline_button", with: optin.decline_button
      fill_in "optin_background_color", with: optin.background_color
      fill_in "optin_text_color", with: optin.text_color
      fill_in "optin_timer", with: optin.timer
    end

    click_button "Save"

    expect(shop.reload.optins.pwa.first).to have_attributes optin_attributes
  end
end
