class AddDateToSubscriberCounts < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriber_counts, :date, :date, default: -> { 'CURRENT_DATE' }
  end
end
