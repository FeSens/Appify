ShopifyApp.configure do |config|
  config.application_name = "Aplicatify"
  config.api_key = Rails.application.credentials.dig(:shopify, :api_key)
  config.secret = Rails.application.credentials.dig(:shopify, :api_secret)
  config.old_secret = ""
  config.scope = "read_themes, write_themes, read_orders, read_checkouts" # Consult this page for more scope options:
                                 # https://help.shopify.com/en/api/getting-started/authentication/oauth/scopes
  config.embedded_app = false
  config.api_version = "2020-04"
  config.shop_session_repository = 'Shop'
  config.after_authenticate_job = { job: "Shopify::AfterAuthenticateJob", inline: true }
  config.webhooks = [
    {topic: 'checkouts/create', address: 'https://appify-skin.herokuapp.com/webhooks/checkouts_create', format: 'json',
      fields: ['id', 'token', 'cart_token']},
    {topic: 'app/uninstalled', address: 'https://appify-skin.herokuapp.com/webhooks/app_uninstalled', format: 'json'},
    {topic: 'orders/create', address: 'https://appify-skin.herokuapp.com/webhooks/orders_create', format: 'json', 
     fields: ['admin_graphql_api_id', 'total_line_items_price', 'name']},
  ]
end

# ShopifyApp::Utils.fetch_known_api_versions                        # Uncomment to fetch known api versions from shopify servers on boot
# ShopifyAPI::ApiVersion.version_lookup_mode = :raise_on_unknown    # Uncomment to raise an error if attempting to use an api version that was not previously known