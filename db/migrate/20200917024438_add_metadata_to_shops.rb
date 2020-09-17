class AddMetadataToShops < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :metadata, :jsonb
  end
end
