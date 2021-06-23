class CreateInteractions < ActiveRecord::Migration[6.1]
  def change
    create_table :interactions do |t|
      t.references :journey, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
