class CartRecoveryJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Shop.each do |shop|
      automation = shop.automations.cart_recovery
      return unless automation.enabled

      pushes = shop.carts.where('updated_at < ? and tries < ?', automation.delay.hours.ago, automation.max_tries).abandoned.recoverable.pluck(:push_id)
      pushes = Push.find(pushes)
      
      campaign = shop.campaigns.create(
        name: "Cart Recovery", 
        tag: "cart recovery automation", 
        title: automation.title, 
        body: automation.body, 
        url: automation.url, 
        release_date: DateTime.now,
      )
      campaign.pushes << pushes

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
  end
end
