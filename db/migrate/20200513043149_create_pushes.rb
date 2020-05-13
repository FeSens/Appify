class CreatePushes < ActiveRecord::Migration[6.0]
  def change
    create_table :pushes do |t|
      t.references :customer, null: true, foreign_key: true
      t.string :endpoint
      t.string :auth
      t.string :p256dh

      t.timestamps
    end
  end
end
