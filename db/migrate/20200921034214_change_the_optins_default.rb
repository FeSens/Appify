class ChangeTheOptinsDefault < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:optins, :enabled, false)
  end
end
