class Push < ApplicationRecord
  belongs_to :customer, optional: true
  belongs_to :shop, optional: true
end
