class Shop::Nuvemshop < Shop
  validates :shopify_domain, presence: true
  validates :shopify_token, presence: true
  
  def with_nuvemshop_session(&block)
    ::NuvemshopAPI::Session.temp(
      store_id: shopify_domain,
      token: shopify_token,
      &block
    )
  end
end