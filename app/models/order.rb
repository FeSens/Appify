class Order < ApplicationRecord
  belongs_to :shop
  belongs_to :campaing, optional: true

  scope :this_month, -> { where(arel_table[:created_at].gt(Date.today.at_beginning_of_month)) }
end
