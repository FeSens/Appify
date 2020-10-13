class CreateAutomations < ActiveRecord::Migration[6.0]
  def change
    create_table :automations do |t|
      t.string :name
      t.string :type
      t.jsonb :config
      t.references :shop, null:false, foreign_key: true

      t.timestamps
    end
  end
end
