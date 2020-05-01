class ChangeManifestDefault < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:manifests, :start_url, from: "/", to: "/?utm_source=homescreen")
  end
end
