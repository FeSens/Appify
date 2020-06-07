class Order < ApplicationRecord
  belongs_to :shop
  belongs_to :campaing, optional: true
end
