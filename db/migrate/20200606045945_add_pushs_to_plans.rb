class AddPushsToPlans < ActiveRecord::Migration[6.0]
  def change
    add_column :plans, :push_limit, :integer
  end
end
