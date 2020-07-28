class AddTriesToCarts < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :tries, :integer, default: 0
  end
end
