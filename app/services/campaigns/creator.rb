module Campaigns
  class Creator
    def initialize(campaign, targeter)
      @campaign = campaign
      @targeter = targeter
    end
    
    def call
      send_push_messages
    end

    def icon
      shop = campaign.shop
      return if shop.manifest.icon.blank?
  
      shop.manifest.icon.variant(resize_to_fit: [192, 192]).processed.service_url.sub(/\?.*/, '')
    end

    def send_push_messages
      targeter.call.each do |customer|
        message = {
          title: campaign.title,
          body: campaign.body,
          url: campaign.url,
          campaign_id: campaign.id,
          icon: icon
        }

        PushSenderJob.perform_later(customer, message)
      end
    end
  end
end
