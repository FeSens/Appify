class AppUninstalledJob < ActiveJob::Base
  def perform(shop_domain:, _webhook:)
    shop = Shop.find_by(shopify_domain: shop_domain)

    return unless shop.nil?

    logger.error("#{self.class} failed: cannot find shop with domain '#{shop_domain}'")

    shop.destroy
  end
end
