module Pushes
  class MessageBuilder < ApplicationService
    attr_reader :campaign, :message, :url, :title

    def initialize(campaign, message, url, title: nil)
      @campaign = campaign
      @message = message
      @url = url
      @title = title
    end

    def call
      {
        title: title || campaign.title,
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
