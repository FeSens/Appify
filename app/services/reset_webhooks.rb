# app/services/tweet_creator.rb
class ResetWebhooks
  def init_webhooks
    webhooks = [
      { topic: "checkouts/create", address: "https://appify-skin.herokuapp.com/webhooks/checkouts_create",
        format: "json",
        fields: %w[id token cart_token line_items] },
      { topic: "app/uninstalled",
        address: "https://appify-skin.herokuapp.com/webhooks/app_uninstalled",
        format: "json" },
      { topic: "orders/create",
        address: "https://appify-skin.herokuapp.com/webhooks/orders_create",
        format: "json",
        fields: %w[checkout_token cart_token line_items admin_graphql_api_id total_line_items_price name] }
    ]
    webhooks.each do |topic|
      webhook = ShopifyAPI::Webhook.create(topic)
      raise "Webhook invalid: #{webhook.errors}" unless webhook.valid?
    end
  end

  def clean_webhooks
    ShopifyAPI::Webhook.all.each(&:destroy)
  end

  def call
    Shop.all.each do |shop|
      shop.with_shopify_session do
        clean_webhooks
        init_webhooks
      end
    end
  end
end
