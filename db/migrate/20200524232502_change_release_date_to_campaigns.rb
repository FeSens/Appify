class ChangeReleaseDateToCampaigns < ActiveRecord::Migration[6.0]
  def change
    change_table :campaigns do |t|
      t.change :release_date, :datetime, null: false, default: 5.minutes.from_now
    end
  end
end
