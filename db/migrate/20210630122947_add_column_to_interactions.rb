class AddColumnToInteractions < ActiveRecord::Migration[6.1]
  def change
    add_reference :interactions, :campaign, null: true, foreign_key: true
    add_reference :interactions, :shop, null: false, foreign_key: true
    add_reference :interactions, :_next, null: true, foreign_key: { to_table: :interactions }
    add_reference :interactions, :_prev, null: true, foreign_key: { to_table: :interactions }
    add_column :interactions, :count, :integer
    add_column :interactions, :settings, :jsonb  
    add_column :interactions, :run_by, :datetime
    add_column :interactions, :type, :string
  end
end
