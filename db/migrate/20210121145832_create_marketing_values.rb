class CreateMarketingValues < ActiveRecord::Migration[6.0]
  def change
    create_table :marketing_values do |t|
      t.decimal :cpc
      t.decimal :cps
      t.decimal :cpd
      t.references :shop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
