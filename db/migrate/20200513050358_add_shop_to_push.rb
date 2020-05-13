class AddShopToPush < ActiveRecord::Migration[6.0]
  def change
    add_column :pushes, :shop, :string
  end
end
