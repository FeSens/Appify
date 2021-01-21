class CreateMarketingValues < ActiveRecord::Migration[6.0]
  def up
    create_table :marketing_values do |t|
      t.decimal :cpc
      t.decimal :cps
      t.decimal :cpd
      t.references :shop, null: false, foreign_key: true

      t.timestamps
    end

    Shop.all.each do |shop|
      shop.create_marketing_value(cpc: 0.27, cps: 2.50, cpd: 3.50)
    end
  end

  def down
    drop_table :marketing_values
  end
end
