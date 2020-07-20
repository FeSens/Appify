class ChangeCartHashColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :carts, :hash, :hexdigest
  end
end
