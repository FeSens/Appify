class ChangeDefaultOfManifest < ActiveRecord::Migration[6.0]
  def change
    change_column_default :manifests, :name, "My Store Name"
    change_column_default :manifests, :short_name, "My App name"
  end
end
