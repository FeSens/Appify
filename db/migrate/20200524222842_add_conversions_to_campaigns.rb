class AddConversionsToCampaigns < ActiveRecord::Migration[6.0]
  def change
    add_column :campaigns, :impressions, :integer, default: 0
    add_column :campaigns, :clicks, :integer, default: 0
  end
end
