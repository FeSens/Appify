class AddSubdomainToShops < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :subdomain, :string, null: true
    add_index :shops, :subdomain, unique: true
  end
end
