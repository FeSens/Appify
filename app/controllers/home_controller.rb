# frozen_string_literal: true

class HomeController < AuthenticatedController
  def index
    @products = ShopifyAPI::Product.find(:all, params: { limit: 10 })
    @webhooks = ShopifyAPI::Webhook.find(:all)
    @scripttags = ShopifyAPI::ScriptTag.find(:all)
    @scripttags.each { |v| ShopifyAPI::ScriptTag.delete(v.id) }
    ShopifyAPI::ScriptTag.create(event: "onload", src: "#{domain}/apps/script/serviceworker-register.js")
    @scripttags = ShopifyAPI::ScriptTag.find(:all)

    binding.pry
  end
end
