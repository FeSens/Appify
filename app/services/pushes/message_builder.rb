module Pushes
  class MessageBuilder < ApplicationService
    attr_reader :campaign, :message, :url

    def initialize(campaign, message, url)
      @campaign = campaign
      @message = message
      @url = url
    end

    def call
      {
        title: campaign.title,
        body: message,
        url: url,
        campaign_id: campaign.id,
        icon: icon
      }
    end

    def icon
      @icon ||= begin
        shop = campaign.shop
        return if shop.manifest.icon.blank?

        shop.manifest.icon.variant(resize_to_fit: [192, 192]).processed.service_url.sub(/\?.*/, "")
      end
    end
  end
end
