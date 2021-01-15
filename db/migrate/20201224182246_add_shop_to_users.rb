class AddShopToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :shop, null: true, foreign_key: true
  end
end
