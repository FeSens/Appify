class AddNameToShops < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :name, :string
    remove_column :shops, :shop_name, :string
  end
end
