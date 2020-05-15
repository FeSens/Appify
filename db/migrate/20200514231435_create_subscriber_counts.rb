class CreateSubscriberCounts < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriber_counts do |t|
      t.references :shop, null: false, foreign_key: true
      t.integer :service
      t.integer :count

      t.timestamps
    end
  end
end
