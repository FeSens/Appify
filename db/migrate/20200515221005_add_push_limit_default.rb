class AddPushLimitDefault < ActiveRecord::Migration[6.0]
  def change
    change_column :push_interactions, :count, :integer, default: 0
  end
end
