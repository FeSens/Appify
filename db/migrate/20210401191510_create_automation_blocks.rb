class CreateAutomationBlocks < ActiveRecord::Migration[6.1]
  def change
    create_table :automation_blocks do |t|
      t.bigint :_next_id, null: true, foreign_key: true
      t.bigint :_prev_id, null: true, foreign_key: true
      t.references :campaign, null: true, foreign_key: true
      t.references :shop, null: false, foreign_key: true
      t.integer :count, default: 0
      t.datetime :run_by
      t.string :type

      t.timestamps
    end
  end
end
