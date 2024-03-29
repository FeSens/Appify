class OrdersCreateJob < ApplicationJob
  class JourneyNotAvailable < StandardError; end
  queue_as :low
  sidekiq_options retry: 5
  attr_accessor :webhook, :utm_source, :utm_medium, :utm_campaign, :campaign, :shop

  def perform(shop_domain:, webhook:)
    return nil if true

    @webhook = webhook
    @shop = Shop.find_by(shopify_domain: shop_domain)
    if shop.nil?
      logger.error("#{self.class} failed: cannot find shop with domain '#{shop_domain}'")
      return
    end

    IdentifyCart.new(webhook).call

    shop.with_shopify_session do
      utm_parameters
    end
    return unless utm_source == "aplicatify"

    @campaign = shop.campaigns.find_by(name: utm_campaign)
    shop.orders.create(campaign_id: campaign&.id, total: webhook[:total_line_items_price], name: webhook[:name])
  end

  def utm_parameters
    query = ShopifyAPI::GraphQL.client.parse <<-GRAPHQL
    {
      order(id: "#{@webhook[:admin_graphql_api_id]}") {
        customerJourney {
          lastVisit {
            utmParameters {
              campaign
              medium
              source
            }
          }

          firstVisit {
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
    journey = result.data&.order&.customer_journey
    raise JourneyNotAvailable unless journey.present?

    visit = journey.last_visit.present? ? journey.last_visit.utm_parameters : journey.first_visit.utm_parameters
    @utm_medium = visit&.medium
    @utm_campaign = visit&.campaign
    @utm_source = visit&.source
  end
end
