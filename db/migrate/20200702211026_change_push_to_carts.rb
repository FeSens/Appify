class ChangePushToCarts < ActiveRecord::Migration[6.0]
  def change
    change_column :carts, :push_id, :bigint, null: true
  end
end
