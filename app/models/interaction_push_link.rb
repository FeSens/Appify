class InteractionPushLink < ApplicationRecord
  belongs_to :push
  belongs_to :interaction
end
