class RemoveConstraintsFromShops < ActiveRecord::Migration[6.0]
  def change
    change_column_default :shops, :type, "Shop::Shopify"
    change_column_null :shops, :shopify_domain, true
    change_column_null :shops, :shopify_token, true
  end
end
