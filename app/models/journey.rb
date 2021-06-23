class Journey < ApplicationRecord
  belongs_to :shop
  has_many :interactions
end
