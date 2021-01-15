class Shop::Shopify < Shop
  include ShopifyApp::ShopSessionStorage
  
  validates :shopify_domain, presence: true
  validates :shopify_token, presence: true

  def api_version
    ShopifyApp.configuration.api_version
  end
end