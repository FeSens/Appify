class AddAutomaticCampaignsToCampaigns < ActiveRecord::Migration[6.0]
  def change
    add_reference :campaigns, :automatic_campaign, null: true, foreign_key: true
    remove_reference :campaigns, :automation
  end
end
