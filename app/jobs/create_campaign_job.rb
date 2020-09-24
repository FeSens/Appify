class CreateCampaignJob < ApplicationJob
  queue_as :critical
  attr_accessor :campaign

  def perform(campaign, targeter, args: nil)
    @campaign = campaign
    return reschedule if postpone?

    Campaigns::Creator.call(campaign, targeter, args: args)
  end

  def postpone?
    campaign.release_date > Time.now
  end

  def reschedule
    CreateCampaignJob.set(wait_until: campaign.release_date).perform_later(campaign)
  end
end
