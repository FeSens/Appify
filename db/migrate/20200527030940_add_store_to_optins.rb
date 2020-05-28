class AddStoreToOptins < ActiveRecord::Migration[6.0]
  def change
    add_reference :optins, :shop, null: false, foreign_key: true
  end
end
