class AddShopsToPush < ActiveRecord::Migration[6.0]
  def change
    change_table :pushes do |t|
      t.references :shop
    end
    remove_column :pushes, :shop
  end
end
