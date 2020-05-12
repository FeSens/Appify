class CreateConfigurations < ActiveRecord::Migration[6.0]
  def change
    create_table :configurations do |t|
      t.references :shop, null: false, foreign_key: true
      t.boolean :enable_timer, default: false, null: false
      t.boolean :enable_url, default: false, null: false
      t.boolean :enable_pages, default: false, null: false
      t.boolean :and, default: false, null: false
      t.string :modal_text, default: "Do you want to install our app for exclusive promotions?", null: false
      t.integer :timer, default: 20000, null: false
      t.string :url, default: "/", null: false
      t.integer :pages, default: 2, null: false

      t.timestamps
    end
  end
end
