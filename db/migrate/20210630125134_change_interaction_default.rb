class ChangeInteractionDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :interactions, :count, 0
  end
end
