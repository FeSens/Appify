class AddSubscriberId < ActiveRecord::Migration[6.0]
  def change
    add_column :pushes, :subscriber_id, :string
  end
end
