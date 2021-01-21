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
      shop.create_marketing_value(cpc: 0.446, cps: 1.78, cpd: 3.47)
    end
  end

  def down
    drop_table :marketing_values
  end
end
