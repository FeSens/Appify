class AddPlanNameToShops < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :plan_name, :integer, default: 0
  end
end
