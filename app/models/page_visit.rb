class PageVisit < ApplicationRecord
  belongs_to :push, optional: true
end
