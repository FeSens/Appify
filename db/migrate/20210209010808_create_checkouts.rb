class CreateCheckouts < ActiveRecord::Migration[6.0]
  def change
    create_table :checkouts do |t|
      t.string :subscriber_id, null: false, foreign_key: true
      t.string :checkout_id
      t.string :utm_campaign

      t.timestamps
    end
  end
end
