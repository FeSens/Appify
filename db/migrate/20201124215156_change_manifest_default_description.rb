class ChangeManifestDefaultDescription < ActiveRecord::Migration[6.0]
  def change
    change_column_default :manifests, :description, "Powered by Aplicatify"
  end
end
