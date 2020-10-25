class AddSubiscriberIdIndex < ActiveRecord::Migration[6.0]
  def change
    add_index(:page_visits, :subscriber_id)
    add_index(:pushes, :subscriber_id)
  end
end
