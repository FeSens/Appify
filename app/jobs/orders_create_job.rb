class OrdersCreateJob < ActiveJob::Base
  attr_accessor :webhook, :landing_site, :utm_source, :utm_medium, :utm_campaign, :campaign, :shop

  def perform(shop_domain:, webhook:)
    @webhook = webhook
    @shop = Shop.find_by(shopify_domain: shop_domain)
    if shop.nil?
      logger.error("#{self.class} failed: cannot find shop with domain '#{shop_domain}'")
      return
    end

    shop.with_shopify_session do
      @landing_site = ShopifyAPI::Order.find(webhook[:id], fields: 'landing_site')
    end
    return unless source_verified?

    @campaign = shop.campaigns.find_by(name: utm_campaign)

    shop.orders.create(campaign_id: campaign&.id, landing_site: landing_site, total: webhook[:total_line_items_price], name: webhook[:name])
  end

  def source_verified?
    return false unless landing_site.include? "utm_source=aplicatify"
    h = extract_parameters_from_url(landing_site)
    @utm_medium, @utm_campaign = h[:utm_medium],  h[:utm_campaign]
    true
  end

  def extract_parameters_from_url(url)
    uri = URI.parse(url)
    return Rack::Utils.parse_nested_query(uri.query)
  end

end
