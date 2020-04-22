# frozen_string_literal: true

class HomeController < AuthenticatedController
  def index
    @products = ShopifyAPI::Product.find(:all, params: { limit: 10 })
    @webhooks = ShopifyAPI::Webhook.find(:all)
    @manifest = shop.manifest
    regiter_script
  end

  private

  def regiter_script
    @scripttags = ShopifyAPI::ScriptTag.find(:all)
    return nil if @scripttags.select { |i| i.src.include? script_url}.present?

    ShopifyAPI::ScriptTag.create(event: "onload", src: script_url)
    @scripttags = ShopifyAPI::ScriptTag.find(:all)
  end

  def script_url
    "https://#{domain}/apps/script/serviceworker-register.js"
  end
end
