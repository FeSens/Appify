class AddReleaseDateToCampaigns < ActiveRecord::Migration[6.0]
  def change
    add_column :campaigns, :release_date, :date
  end
end
