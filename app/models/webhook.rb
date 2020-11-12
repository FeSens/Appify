class Webhook < ApplicationRecord
  belongs_to :shop, optional: true
  serialize :scope
end
