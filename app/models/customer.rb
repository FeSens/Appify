class Customer < ApplicationRecord
  has_many :pushes, dependent: :destroy
end
