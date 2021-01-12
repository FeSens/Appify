class DropPlanNameFromShops < ActiveRecord::Migration[6.0]
  def change
    remove_column :shops, :plan_name
  end
end
