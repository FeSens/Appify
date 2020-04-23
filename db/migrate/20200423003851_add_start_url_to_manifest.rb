class AddStartUrlToManifest < ActiveRecord::Migration[6.0]
  def change
    add_column :manifests, :start_url, :string
  end
end
