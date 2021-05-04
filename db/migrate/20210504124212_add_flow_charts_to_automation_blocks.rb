class AddFlowChartsToAutomationBlocks < ActiveRecord::Migration[6.1]
  def change
    add_reference :automation_blocks, :flow_chart, null: false, foreign_key: true
  end
end
