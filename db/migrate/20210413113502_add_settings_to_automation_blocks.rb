class AddSettingsToAutomationBlocks < ActiveRecord::Migration[6.1]
  def change
    add_column :automation_blocks, :settings, :jsonb
  end
end
