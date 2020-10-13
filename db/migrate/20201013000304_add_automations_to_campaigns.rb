class AddAutomationsToCampaigns < ActiveRecord::Migration[6.0]
  def change
    add_reference :campaigns, :automation, null: true, foreign_key: true
  end
end
