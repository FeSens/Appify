class CreateFlowCharts < ActiveRecord::Migration[6.1]
  def change
    create_table :flow_charts do |t|
      t.references :shop, null: false, foreign_key: true
      t.jsonb :chart_metadata

      t.timestamps
    end
  end
end
