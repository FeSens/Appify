class CreateAutomations < ActiveRecord::Migration[6.0]
  def change
    create_table :automations do |t|
      t.references :shop, null: false, foreign_key: true
      t.jsonb :settings
      t.string :kind

      t.timestamps
    end
  end
end
