class CreatePageVisits < ActiveRecord::Migration[6.0]
  def change
    create_table :page_visits do |t|
      t.references :push, null: false, foreign_key: true
      t.integer :time_spent
      t.string :path

      t.timestamps
    end
  end
end
