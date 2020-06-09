# frozen_string_literal: true

module Shopify
  class AfterAuthenticateJob < ApplicationJob
    attr_accessor :shop

    def perform(shop_domain:)
      @shop = Shop.find_by(shopify_domain: shop_domain)

      shop.with_shopify_session do
        configure_store
        @themes_id = ShopifyAPI::Theme.find(:all)
        @themes_id.each do |t|
          layout = ShopifyAPI::Asset.find('layout/theme.liquid', params: { theme_id: t.id })
          create_asset unless ShopifyAPI::Asset.find('snippets/aplicatify-snippet.liquid', params: { theme_id: t.id })
          unless layout.value.include? "{% include 'aplicatify-snippet' %}"
            l = layout.value.split('<head>')
            layout.value = `#{l[0]}
                            <!-- APLICATIFY:START -->
                              {% include 'aplicatify-snippet' %}
                            <!-- APLICATIFY:END -->
                            #{l[1]}`
            layout.save
          end
        end
      end
    end

    def script_urls
      ['/apps/script/serviceworker-register.js',
       '/apps/script/public/preferences.js']
    end

    def manifest_url
      '/apps/script/public/manifest.json'
    end

    def configure_store
      s = ShopifyAPI::Shop.current
      shop.update(domain: s.domain, name: s.name)
      p = Plan.find_by(name: s.plan_name)
      shop.update(push_limit: p.push_limit) if p
    end

    def create_asset
      ShopifyAPI::Asset.create(key: "snippets/aplicatify-snippet.liquid", 
        value: `
          <link rel='manifest' href='#{manifest_url}'>
          <script type='text/javascript' async='' src='#{script_urls[0]}'></script>
          <script type='text/javascript' async='' src='#{script_urls[1]}'></script>
        `)
    end
  end
end
