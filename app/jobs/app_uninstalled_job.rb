class AppUninstalledJob < ActiveJob::Base
  def perform(shop_domain:, webhook:)
    shop = Shop.find_by(shopify_domain: shop_domain)
    shop.update(active: false)
    #shop.destroy
  end
end
