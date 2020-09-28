class AddLocaleToShop < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :locale, :string, default: 'en'
  end
end
