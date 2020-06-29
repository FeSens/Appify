class ChangeEntryPointForManifests < ActiveRecord::Migration[6.0]
  def change
    change_column_default :manifests, :start_url, "/?utm_source=aplicatify&utm_medium=app&utm_campaign=app"
  end
end
