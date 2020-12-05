class Plan < ApplicationRecord
  validates :capped_amount, numericality: { greater_than_or_equal_to: :price }

  has_many :shops

  after_update :update_shops_limit

  private

  def update_shops_limit
    shops.where("push_limit < ?", push_limit).update_all(push_limit: push_limit)
  end
end
