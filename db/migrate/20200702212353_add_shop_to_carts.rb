class AddShopToCarts < ActiveRecord::Migration[6.0]
  def change
    add_reference :carts, :shop, null: true, foreign_key: true
  end
end
