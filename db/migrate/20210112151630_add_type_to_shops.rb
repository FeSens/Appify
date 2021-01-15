class AddTypeToShops < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :type, :string, default: "Shop::Shopify"
  end
end
