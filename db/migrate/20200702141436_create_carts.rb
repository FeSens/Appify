class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.references :customer, null: true, foreign_key: true
      t.references :push, null: false, foreign_key: true
      t.string :token
      t.jsonb :data

      t.timestamps
    end
  end
end
