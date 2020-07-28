class CartRecoveryJob < ApplicationJob
  queue_as :default
  attr_accessor :cart, :push, :shop, :automation, :campaign

  def perform(cart_id)
    cart = Cart.find(cart_id)
    return unless cart.push_id.present? && cart.abandoned

    push = Push.find(cart.push_id)
    return unless  cart.push_id == push.carts.last

    shop = Shop.find(cart.shop_id)
    automation = shop.automations.cart_recovery
    return unless automation.enabled
    return unless cart.tries >= automation.max_tries
    return reschedule if postpone?

    n = shop.campaigns.where("name ILIKE ?", "%Cart Recovery%").count
    campaign = shop.campaigns.find_or_create(
      name: "Cart Recovery #{n + 1}", 
      tag: "cart recovery automation", 
      title: automation.title, 
      body: automation.body, 
      url: automation.url, #Gotta build the url for the cart man
      release_date: DateTime.now,
    )

    message = {
      title: campaign.title,
      body: campaign.body,
      url: campaign.url,
      campaign_id: campaign.id,
      icon: icon
    }

    PushSenderJob.perform_later(customer, message)
    campaign.pushes << push
    Cart.increment_counter(:tries, cart.id)
  end

  def build_url
    url = "cart/"
    @cart.data['items'].each {|k,v| url += "#{v['variant_id']}:#{v['quantity']},"}
    q = {}
    q["utm_source"] = "aplicatify"
    q["utm_medium"] = "push"
    q["utm_campaign"] = @campaign.name
    q["ref"] = "aplicatify"

    return "/#{url[0..-2]}?#{q.to_query}"
  end

  def icon
    shop = campaign.shop
    return if shop.manifest.icon.blank?

    shop.manifest.icon.variant(resize_to_fit: [192, 192]).processed.service_url.sub(/\?.*/, '')
  end

  def last_date
    [push.push_subscriber_campaigns.last.updated_at, cart.updated_at].max
  end

  def postpone?
    last_date > automation.delay.hours.ago
  end

  def reschedule
    date = last_date + automation.delay.hours + 5.minutes
    CartRecoveryJob.set(wait_until: date).perform_later(cart.id)
  end
end
