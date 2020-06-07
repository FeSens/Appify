class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :shop, null: false, foreign_key: true
      t.references :campaign, null: true, foreign_key: true
      t.integer :customer_id
      t.string :landing_site
      t.string :order_name
      t.decimal :total

      t.timestamps
    end
  end
end
