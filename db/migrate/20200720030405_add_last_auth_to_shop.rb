class AddLastAuthToShop < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :last_auth, :datetime
    add_column :shops, :last_active, :datetime
  end
end
