class CreateWebhooks < ActiveRecord::Migration[6.0]
  def change
    create_table :webhooks do |t|
      t.references :shop, null: true, foreign_key: true
      t.string :scope
      t.string :token

      t.timestamps
    end
  end
end
