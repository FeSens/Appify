class CreateCampaignJob < ApplicationJob
  queue_as :default
  attr_accessor :campaign

  def perform(campaign)
    @campaign = campaign
    return reschedule if postpone?

    pushes = Push.where(shop_id: campaign.shop_id)
    pushes.all.each do |customer|
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

  def icon
    shop = campaign.shop
    shop.manifest.icon.variant(resize_to_fit: [192, 192]).processed.service_url.sub(/\?.*/, '') if shop.manifest.icon.present?
  end

  def postpone?
    campaign.release_date > Time.now
  end

  def reschedule
    CreateCampaignJob.set(wait_until: campaign.release_date).perform_later(campaign)
  end
end
