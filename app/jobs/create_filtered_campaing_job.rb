class CreateFilteredCampaingJob < ApplicationJob
  queue_as :critical
  attr_accessor :campaign
  
  def perform(campaign, filter)
    @campaign = campaign
    return reschedule if postpone?

    filter.each do |push_id, path|
      customer = Push.find(push_id)
      message = {
        title: campaign.title,
        body: campaign.body,
        url: UrlBuilder.call(path, campaign.name),
        campaign_id: campaign.id,
        icon: icon
      }
      PushSenderJob.perform_later(customer, message)
    end
  end

  def icon
    shop = campaign.shop
    return if shop.manifest.icon.blank?

    shop.manifest.icon.variant(resize_to_fit: [192, 192]).processed.service_url.sub(/\?.*/, '')
  end

  def postpone?
    campaign.release_date > Time.now
  end

  def reschedule
    CreateCampaignJob.set(wait_until: campaign.release_date).perform_later(campaign)
  end
end

