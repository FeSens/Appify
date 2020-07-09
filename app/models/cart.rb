class Cart < ApplicationRecord
  belongs_to :customer, optional: true
  belongs_to :push, optional: true
  belongs_to :shop, optional: true

  scope :abandoned, -> { where(abandoned: true) }
  scope :yesterday, -> { where('updated_at < ?', 24.hours.ago) }
  scope :recoverable, -> { where.not(push_id: nil) }
end
