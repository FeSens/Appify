class ChangeLastActivityColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :shops, :last_active, :last_activity
  end
end
