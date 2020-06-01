class ChangeDefaultForManifests < ActiveRecord::Migration[6.0]
  def change
    change_column_default :manifests, :theme_color, "CB505A"
    change_column_default :manifests, :background_color, "FFFFFF"
    change_column_default :manifests, :description, "Track your orders and receive special promos with our new brand app!"
    change_column_default :optins, :title, "Looking for special promos?"
    change_column_default :optins, :body, "Receive special notifications with the hottest offers!"
    change_column_default :optins, :accept_button, "Yes!"
    change_column_default :optins, :timer, 30
  end
end
