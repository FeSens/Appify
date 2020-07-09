class PushSubscriberCampaign < ApplicationRecord
  belongs_to :push
  belongs_to :campaign
end
