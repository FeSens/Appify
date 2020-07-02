class Cart < ApplicationRecord
  belongs_to :customer, optional: true
  belongs_to :push
end
