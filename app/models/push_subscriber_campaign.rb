class PushSubscriberCampaign < ApplicationRecord
  belongs_to :push, optional: true
  belongs_to :campaing, optional: true
end
