class CartRecoveryJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Shop.each do |shop|
      automation = shop.automations.cart_recovery
      return unless automation.enabled

      pushes = shop.carts.where('updated_at < ? and tries < ? and push_id is not null', automation.delay.hours.ago, automation.max_tries).abandoned.recoverable.pluck(:push_id)
      pushes = PushSubscriberCampaign.find_by_sql(
        ['SELECT push_id from (SELECT push_id, max(created_at) as "latest" FROM push_subscriber_campaigns WHERE push_id in (?) GROUP BY push_id) as foo where foo.latest < ?', pushes, automation.delay.hours.ago]
      ).pluck(:push_id)
      pushes = Push.find(pushes)

      n = shop.campaigns.where("name ILIKE ?", "%Cart Recovery%").count
      campaign = shop.campaigns.create(
        name: "Cart Recovery #{n+1}", 
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
