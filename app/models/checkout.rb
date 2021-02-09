class Checkout < ApplicationRecord
  belongs_to :push, foreign_key:"subscriber_id", primary_key: "subscriber_id"
end
