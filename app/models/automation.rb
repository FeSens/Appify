class Automation < ApplicationRecord
  belongs_to :shop
  scope :cart_recovery, -> { where(kind: "cart recovery") }
end
