class CreateOptInCounts < ActiveRecord::Migration[6.0]
  def change
    create_table :opt_in_counts do |t|
      t.references :shop, null: false, foreign_key: true
      t.integer :service
      t.integer :count
      t.datetime :date

      t.timestamps
    end
  end
end
