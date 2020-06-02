class AddShopNameToShops < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :shop_name, :string
  end
end
