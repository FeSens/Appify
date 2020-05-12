class CreateConfigurations < ActiveRecord::Migration[6.0]
  def change
    create_table :configurations do |t|
      t.references :shop, null: false, foreign_key: true
      t.boolean :enable_timer, default: false
      t.boolean :enable_url, default: false
      t.boolean :enable_pages, default: false
      t.boolean :and, default: false
      t.string :modal_text, default: "Do you want to install our app for exclusive promotions?"
      t.integer :timer, default: 20000
      t.string :url, default: "/"
      t.integer :pages, default: 2

      t.timestamps
    end
  end
end
