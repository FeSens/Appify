class ChangeOrderColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :orders, :order_name, :name
  end
end
