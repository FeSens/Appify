class PushSubscriberCampaign < ApplicationRecord
  belongs_to :push
  belongs_to :campaing, optional: true
end
