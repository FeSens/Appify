class BillingCheckJob < ApplicationJob
  queue_as :default

  def perform(current_shop)
    return if current_shop.type == "Shop::Devise" || current_shop.type == "Shop::Nuvemshop"
    current_shop.with_shopify_session do
      @plan = ShopifyAPI::RecurringApplicationCharge.all
      @plan = active?(@plan)
    rescue StandardError => e
      @plan = false
    end
  
    current_shop.update(active: @plan)
  end

  private

  def active?(p)
    p.map { |pp| pp.status == "active" }.any?
  end
end
