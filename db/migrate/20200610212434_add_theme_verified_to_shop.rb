class AddThemeVerifiedToShop < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :theme_verified, :boolean, default: false
  end
end
