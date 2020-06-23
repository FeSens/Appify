class PageVisit < ApplicationRecord
  belongs_to :push, optional: true
  belongs_to :shop
end
