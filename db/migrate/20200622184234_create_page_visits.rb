class CreatePageVisits < ActiveRecord::Migration[6.0]
  def change
    create_table :page_visits do |t|
      t.references :push, null: true, foreign_key: true
      t.integer :time_spent
      t.string :path
      t.string :subscriber_id
      t.datetime :data
      t.decimal :price
      t.boolean :is_available

      t.timestamps
    end
  end
end
