class AddDefaultToSubscriberCounts < ActiveRecord::Migration[6.0]
  def change
    change_column :subscriber_counts, :count, :integer, default: 0
  end
end
