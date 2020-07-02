class AddAbandonedToCarts < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :abandoned, :boolean, default: true
  end
end
