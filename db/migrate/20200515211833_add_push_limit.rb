class AddPushLimit < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :push_limit, :integer, default: 200
  end
end
