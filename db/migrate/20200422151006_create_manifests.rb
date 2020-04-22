class CreateManifests < ActiveRecord::Migration[6.0]
  def change
    create_table :manifests do |t|
      t.references :shop, null: false, foreign_key: true
      t.string :name
      t.string :short_name
      t.string :theme_color
      t.string :background_color
      t.string :display
      t.string :orientation

      t.timestamps
    end
  end
end
