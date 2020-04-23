class AddDefautsToManifest < ActiveRecord::Migration[6.0]
  def change
    change_column :manifests, :start_url, :string, default: "/"
    change_column :manifests, :name, :string, default: "O seu App"
    change_column :manifests, :short_name, :string, default: "App"
    change_column :manifests, :theme_color, :string, default: "#ffffff"
    change_column :manifests, :background_color, :string, default: "#000000"
    change_column :manifests, :display, :string, default: "standalone"
    change_column :manifests, :orientation, :string, default: "portrait"
    add_column :manifests, :lang, :string, default: "pt-BR"
    add_column :manifests, :description, :string, default: "Descrição do seu app aqui"
  end
end