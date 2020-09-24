require "rails_helper"

RSpec.feature "Create Campaign", type: :feature do
  let(:campaign_name) { "Test Campaign 1" }
  let(:campaign) { FactoryBot.build :campaign}

  scenario "User creates a new campaign" do
    FactoryBot.create :shop
    visit new_admin_campaign_path
    
    within "form" do
      fill_in "campaign_name", with: campaign.name
      fill_in "campaign_tag", with: campaign.tag
      fill_in "campaign_title", with: campaign.title
      fill_in "campaign_body", with: campaign.body
      fill_in "campaign_url", with: "google.com"
    end

    #Check if preview is working correctly
    #section = find(:css, '#mac-text')
    #expect(section).to have_text(campaign.body)

    click_button "Send Now"

    expect(page).to have_current_path(admin_campaigns_path)
    expect(page).to have_text(campaign.name)
  end
end