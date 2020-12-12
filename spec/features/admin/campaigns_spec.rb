require "rails_helper"

RSpec.describe "Campaigns", type: :feature do
  let(:campaign_name) { "Test Campaign 1" }
  let(:campaign) { FactoryBot.build :campaign }
  let(:campaign_attributes) { campaign.attributes.slice("name", "title", "body", "url") }

  it "User creates a new campaign" do
    shop = FactoryBot.create :shop
    visit new_admin_campaign_path

    within "form" do
      fill_in "campaign_name", with: campaign.name
      #fill_in "campaign_tag", with: campaign.tag
      fill_in "campaign_title", with: campaign.title
      fill_in "campaign_body", with: campaign.body
      fill_in "campaign_url", with: campaign.url
    end

    # Check if preview is working correctly
    # section = find(:css, '#mac-text')
    # expect(section).to have_text(campaign.body)

    click_button "commit"

    expect(shop.reload.campaigns.last).to have_attributes campaign_attributes
    expect(page).to have_current_path(admin_campaigns_path)
    expect(page).to have_text(campaign.name)
  end

  it "User edit an existing campaign" do
    shop = FactoryBot.create :shop
    existing_campaign = FactoryBot.create :campaign, shop: shop
    visit edit_admin_campaign_path(existing_campaign)

    within "form" do
      fill_in "campaign_name", with: campaign.name
      #fill_in "campaign_tag", with: campaign.tag
      fill_in "campaign_title", with: campaign.title
      fill_in "campaign_body", with: campaign.body
      fill_in "campaign_url", with: campaign.url
    end

    # Check if preview is working correctly
    # section = find(:css, '#mac-text')
    # expect(section).to have_text(campaign.body)

    click_button "commit"

    expect(shop.reload.campaigns.last).to have_attributes campaign_attributes
    expect(page).to have_current_path(admin_campaigns_path)
    expect(page).to have_text(campaign.name)
    expect(page).to have_text(existing_campaign.clicks)
    expect(page).to have_text(existing_campaign.impressions)
    expect(page).not_to have_text(existing_campaign.name)
  end

  it "User list all campaigns" do
    other_campaigns = FactoryBot.create_list :campaign, 3
    shop = FactoryBot.create :shop
    campaigns = FactoryBot.create_list :campaign, 3, shop: shop
    visit admin_campaigns_path

    campaigns.each do |campaign|
      expect(page).to have_text(campaign.name)
      expect(page).to have_text(campaign.clicks)
      expect(page).to have_text(campaign.impressions)
    end

    other_campaigns.each do |campaign|
      expect(page).not_to have_text(campaign.name)
    end
  end
end
