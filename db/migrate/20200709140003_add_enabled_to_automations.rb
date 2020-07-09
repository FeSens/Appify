class AddEnabledToAutomations < ActiveRecord::Migration[6.0]
  def change
    add_column :automations, :enabled, :boolean, default:false
  end
end
