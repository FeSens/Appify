class Manifest < ApplicationRecord
  belongs_to :shop
  has_one_attached :icon

  after_commit :add_default_icon, on: [:create, :update]

  private 
  
  def add_default_icon
    unless icon.attached?
      self.icon.attach(io: File.open(Rails.root.join("app", "assets", "images", "default_app_logo.png")), filename: 'default_app_logo.png' , content_type: "image/png")
    end
  end
end
