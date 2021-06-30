class CreateInteractionPushLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :interaction_push_links do |t|
      t.references :push, null: false, foreign_key: true
      t.references :interaction, null: false, foreign_key: true

      t.timestamps
    end
  end
end
