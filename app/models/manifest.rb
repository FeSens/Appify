class Manifest < ApplicationRecord
  belongs_to :shop
  has_one_attached :icon

end
