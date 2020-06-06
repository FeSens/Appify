class CreatePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :plans do |t|
      t.string :name
      t.decimal :price
      t.integer :trial_days
      t.integer :capped_amount
      t.string :terms

      t.timestamps
    end
  end
end
