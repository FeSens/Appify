class CustomersDataRequestJob < ApplicationJob
  queue_as :default

  def perform(shop_domain:, _webhook:)
    shop = Shop.find_by(shopify_domain: shop_domain)

    if shop.nil?
      logger.error("#{self.class} failed: cannot find shop with domain '#{shop_domain}'")
      return
    end

    shop.with_shopify_session do
    end
  end
end
