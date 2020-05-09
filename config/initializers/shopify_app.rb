ShopifyApp.configure do |config|
  config.application_name = "Aplicatify"
  config.api_key = Rails.application.credentials.dig(:shopify, :api_key)
  config.secret = Rails.application.credentials.dig(:shopify, :api_secret)
  config.old_secret = ""
  config.scope = "write_script_tags, read_themes, write_themes" # Consult this page for more scope options:
                                 # https://help.shopify.com/en/api/getting-started/authentication/oauth/scopes
  config.embedded_app = true
  config.after_authenticate_job = false
  config.api_version = "2020-04"
  config.shop_session_repository = 'Shop'
end

# ShopifyApp::Utils.fetch_known_api_versions                        # Uncomment to fetch known api versions from shopify servers on boot
# ShopifyAPI::ApiVersion.version_lookup_mode = :raise_on_unknown    # Uncomment to raise an error if attempting to use an api version that was not previously known