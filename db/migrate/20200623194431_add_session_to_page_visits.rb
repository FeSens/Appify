class AddSessionToPageVisits < ActiveRecord::Migration[6.0]
  def change
    add_column :page_visits, :session, :string
  end
end
