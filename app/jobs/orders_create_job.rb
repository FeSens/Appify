class OrdersCreateJob < ActiveJob::Base
  attr_accessor :webhook, :utm_source, :utm_medium, :utm_campaign, :campaign, :shop

  def perform(shop_domain:, webhook:)
    @webhook = webhook
    @shop = Shop.find_by(shopify_domain: shop_domain)
    if shop.nil?
      logger.error("#{self.class} failed: cannot find shop with domain '#{shop_domain}'")
      return
    end

    shop.with_shopify_session do
      utm_parameters
    end
    return unless utm_source == "aplicatify"

    @campaign = shop.campaigns.find_by(name: utm_campaign)
    shop.orders.create(campaign_id: campaign&.id, total: webhook[:total_line_items_price], name: webhook[:name])
  end

  def utm_parameters
    query = ShopifyAPI::GraphQL.client.parse <<-'GRAPHQL'
    {
      order(id: "#{webhook[:admin_graphql_api_id]}") {
        customerJourney {
          lastVisit {
            utmParameters {
              campaign
              medium
              source
            }
          }
        }
      }
    }
    GRAPHQL
    result = ShopifyAPI::GraphQL.client.query(query)
    utm = result.data.order.customerJourney.lastVisit.utmParameters
    @utm_medium, @utm_campaign, @utm_source = utm.medium, utm.campaign, utm.source
  end  
end
