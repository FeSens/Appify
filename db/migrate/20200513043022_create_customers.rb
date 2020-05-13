class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.boolean :acceptsMarketing
      t.string :displayName
      t.string :email
      t.string :firstName
      t.string :shopify_id
      t.string :lastName
      t.string :phone

      t.timestamps
    end
  end
end
