class EditPopup < ActiveRecord::Migration[6.0]
  def change
    change_column_default :optins, :background_color, "007bff"
  end
end
