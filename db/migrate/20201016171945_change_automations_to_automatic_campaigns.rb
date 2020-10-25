class ChangeAutomationsToAutomaticCampaigns < ActiveRecord::Migration[6.0]
  def change
    rename_table :automations, :automatic_campaigns
  end
end
