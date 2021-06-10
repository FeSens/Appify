class CreateCampaignJob < ApplicationJob
  queue_as :critical
  attr_accessor :campaign

  def perform(campaign, targeter, **args)
    @campaign = campaign
    return reschedule if postpone?
    return if campaign.sent?

    Campaigns::Creator.call(campaign, targeter, **args) unless Flipper['extra-use'].enabled?(campaign.shop)
  end

  def postpone?
    campaign.release_date > Time.now
  end

  def reschedule
    CreateCampaignJob.set(wait_until: campaign.release_date).perform_later(campaign, targeter, **args)
  end
end
