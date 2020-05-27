class CreateOptins < ActiveRecord::Migration[6.0]
  def change
    create_table :optins do |t|
      t.string :title, default: "Would you like to receive notifications?", null: false
      t.string :body, default: "We can send you special promotions", null: false
      t.string :accept_button, default: "Yes", null: false
      t.string :decline_button, default: "No", null: false
      t.string :background_color, default: "FFFFFF", null: false
      t.string :text_color, default: "000000", null: false
      t.integer :timer, default: 20, null: false
      t.boolean :enabled, default: true, null: false
      t.integer :kind, default: 0, null: false

      t.timestamps
    end
  end
end
