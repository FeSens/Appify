class AddDomainToShops < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :domain, :string
  end
end
