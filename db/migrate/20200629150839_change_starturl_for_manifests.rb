class ChangeStarturlForManifests < ActiveRecord::Migration[6.0]
  def change
    change_column_default :manifests, :start_url, "/?ref=aplicatify&utm_source=aplicatify&utm_medium=app&utm_campaign=app"
  end
end
