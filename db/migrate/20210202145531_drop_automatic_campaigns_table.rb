class DropAutomaticCampaignsTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :campaigns, :automatic_campaign_id
    drop_table :automatic_campaigns
  end
end
