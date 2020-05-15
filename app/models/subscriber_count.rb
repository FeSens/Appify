class SubscriberCount < ApplicationRecord
  belongs_to :shop
  enum service: %i[pwa push]

end
