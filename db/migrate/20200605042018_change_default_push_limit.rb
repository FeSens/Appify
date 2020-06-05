class ChangeDefaultPushLimit < ActiveRecord::Migration[6.0]
  def change
    change_column_default :shops, :push_limit, 25000
  end
end
