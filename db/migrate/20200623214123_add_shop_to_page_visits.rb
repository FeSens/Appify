class AddShopToPageVisits < ActiveRecord::Migration[6.0]
  def change
    add_reference :page_visits, :shop, null: false, foreign_key: true
  end
end
