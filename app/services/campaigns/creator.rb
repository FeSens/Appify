module Campaigns
  class Creator < ApplicationService
    attr_accessor :campaign
    attr_reader :targeter

    def initialize(campaign, targeter, **args)
      @campaign = campaign
      @targeter = "Campaigns::Targeters::#{targeter.to_s.classify}".constantize.new(campaign.shop_id, **args)
    end

    def call
      targeter.call.find_in_batches(batch_size: 1_000) do |targets|
        send_push_messages(targets)
      end
    end

    def icon
      @icon ||= begin
        shop = campaign.shop
        return if shop.manifest.icon.blank?

        shop.manifest.icon.variant(resize_to_fit: [192, 192]).processed.service_url.sub(/\?.*/, "") unless Rails.env.test?
      end
    end

    def image 
      @image ||= begin
        return if campaign.image.blank?

        campaign.image.service_url.sub(/\?.*/, "") unless Rails.env.test?
      end
    end

    def filterd_targets(targets)
      ids = campaign.pushes.pluck(:id)
      return targets unless ids.present?

      targets #targets.reject { |t| ids.include?(t.id) }
    end

    def create_associations(targets)
      filterd_targets = filterd_targets(targets)
      associations = filterd_targets.map do |p|
        {
          campaign_id: campaign.id,
          push_id: p.id,
          created_at: Time.now,
          updated_at: Time.now
        }
      end
      PushSubscriberCampaign.insert_all(associations) if associations.present?
    end

    def send_push_messages(targets)
      create_associations(targets)
      message = {
        title: campaign.title,
        body: campaign.body,
        url: campaign.url,
        campaign_id: campaign.id,
        icon: icon,
        requireInteraction: true,
        vibrate: [100, 50, 100],
        data: { 
          campaign_id: campaign.id,
          url: campaign.url,
         }
      }
      message[:data][:image] = image

      message_list = [message] * targets.length
      if Flipper['jaiminho'].enabled?(campaign.shop)
        jaiminho = Pushes::Brokers::Jaiminho.new
        Pushes::Sender.new(broker: jaiminho).deliver_batch(targets, message_list)
      else
        Pushes::Sender.new.deliver_batch(targets, message_list)
      end
    end
  end
end
