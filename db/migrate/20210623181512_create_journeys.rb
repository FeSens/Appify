class CreateJourneys < ActiveRecord::Migration[6.1]
  def change
    create_table :journeys do |t|
      t.references :shop
      t.string :name

      t.timestamps
    end
  end
end
