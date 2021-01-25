class AddActiveToShop < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :active, :boolean, default: true
  end
end
