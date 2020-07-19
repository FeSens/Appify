class AddHashToCart < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :hash, :string
  end
end
