class CreateAutomationBlockLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :automation_block_links do |t|
      t.references :automation_block, null: false, foreign_key: true
      t.references :push, null: false, foreign_key: true

      t.timestamps
    end
  end
end
