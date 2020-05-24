class CreateCampaigns < ActiveRecord::Migration[6.0]
  def change
    create_table :campaigns do |t|
      t.references :shop, null: false, foreign_key: true
      t.string :name
      t.string :tag
      t.integer :segmentation_size
      t.integer :delivered
      t.string :title
      t.text :body
      t.string :url

      t.timestamps
    end
  end
end
