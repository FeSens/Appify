class CreatePushInteractions < ActiveRecord::Migration[6.0]
  def change
    create_table :push_interactions do |t|
      t.references :shop, null: false, foreign_key: true
      t.date :date
      t.integer :count

      t.timestamps
    end
  end
end
