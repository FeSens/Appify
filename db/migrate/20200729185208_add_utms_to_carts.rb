class AddUtmsToCarts < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :utm_medium, :string
    add_column :carts, :utm_campaign, :string
    add_column :carts, :utm_source, :string
  end
end
