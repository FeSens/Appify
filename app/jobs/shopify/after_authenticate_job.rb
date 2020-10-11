# frozen_string_literal: true

module Shopify
  class AfterAuthenticateJob < ApplicationJob
    attr_accessor :shop

    def perform(shop_domain:)
      @shop = Shop.find_by(shopify_domain: shop_domain)

      shop.touch(:last_auth)

      shop.with_shopify_session do
        configure_store
        modify_theme
      end
    end

    def script_urls
      ["/apps/script/serviceworker-register.js",
       "/apps/script/public/preferences.js"]
    end

    def manifest_url
      "/apps/script/public/manifest.json"
    end

    def configure_store
      s = ShopifyAPI::Shop.current
      shop.update(domain: s.domain, name: s.name, locale: s.primary_locale)
      p = Plan.find_by(name: s.plan_name)
      shop.update(push_limit: p.push_limit) if p
    end

    def create_asset
      ShopifyAPI::Asset.create(key: "snippets/aplicatify-snippet.liquid",
                               value: "<link rel='manifest' href='#{manifest_url}'>\n<script type='text/javascript' async='' src='#{script_urls[0]}'></script>\n<script type='text/javascript' async='' src='#{script_urls[1]}'></script>")
    end

    def modify_theme!
      layout = ShopifyAPI::Asset.find("layout/theme.liquid", params: { role: "main" })
      create_asset
      unless layout.value.include? "{% include 'aplicatify-snippet' %}"
        l = layout.value.split("<head>", 2)
        layout.value = "#{l[0]}\n<head>\n  <!-- APLICATIFY:START -->\n {% include 'aplicatify-snippet' %}\n  <!-- APLICATIFY:END -->\n#{l[1]}"
        layout.save
      end
      shop.update(theme_verified: true)
    end

    def modify_theme
      modify_theme!
    rescue StandardError => e
      Rollbar.error(e, "Shop (#{shop.id}) theme could not be modified")
      shop.update(theme_verified: false)
    end
  end
end
