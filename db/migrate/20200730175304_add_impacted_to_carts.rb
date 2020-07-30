class AddImpactedToCarts < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :impacted, :boolean, default: false
  end
end
