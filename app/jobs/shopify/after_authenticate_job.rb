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
          unless layout.value.include? "<link rel='manifest' href='#{manifest_url}'>"
            l = layout.value.split('<head>')[1]
            layout.value = "<head> <link rel='manifest' href='#{manifest_url}'> #{l}"
            layout.save
          end
          script_urls.each do |script_url|
            next if layout.value.include? "<script type='text/javascript' async='' src='#{script_url}'></script>"

            l = layout.value.split('<head>')[1]
            layout.value = "<head> <script type='text/javascript' async='' src='#{script_url}'></script> #{l}"
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
    end
  end
end
