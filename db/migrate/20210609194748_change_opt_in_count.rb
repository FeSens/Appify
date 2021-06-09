class ChangeOptInCount < ActiveRecord::Migration[6.1]
  def change
    change_column :opt_in_counts, :date, :date, default: -> { 'CURRENT_DATE' }
    change_column :opt_in_counts, :count, :integer, default: 0
  end
end
