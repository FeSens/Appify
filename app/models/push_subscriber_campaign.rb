class PushSubscriberCampaign < ApplicationRecord
  belongs_to :push, optional: false
  belongs_to :campaign, optional: false
end
