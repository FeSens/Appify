class AddAcceptedToOptInCounts < ActiveRecord::Migration[6.1]
  def change
    add_column :opt_in_counts, :accepted, :integer, default: 0
    add_column :opt_in_counts, :declined, :integer, default: 0
  end
end
