module Campaigns
  class Creator < ApplicationService
    attr_accessor :campaign
    attr_reader :targeter

    def initialize(campaign, targeter, **args)
      @campaign = campaign
      @targeter = "Campaigns::Targeters::#{targeter.to_s.classify}".constantize.new(campaign.shop_id, **args)
    end

    def call
      send_push_messages
    end

    def icon
      @icon ||= begin
        shop = campaign.shop
        return if shop.manifest.icon.blank?

        shop.manifest.icon.variant(resize_to_fit: [192, 192]).processed.service_url.sub(/\?.*/, "")
      end
    end

    def filterd_targets(targets)
      ids = campaign.pushes.pluck(:id)
      return targets unless ids.present?

      targets.where("id not in (?)", ids)
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

    def send_push_messages
      targets = targeter.call

      create_associations(targets)

      message = {
        title: campaign.title,
        body: campaign.body,
        url: campaign.url,
        campaign_id: campaign.id,
        icon: icon
      }

      message_list = [message] * targets.length
      if Flipper['jaiminho'].enabled?(campaign.shop)
        Pushes::Sender.new(broker: :jaiminho).deliver_batch(targets, message_list)
      else
        Pushes::Sender.new.deliver_batch(targets, message_list)
      end
    end
  end
end
