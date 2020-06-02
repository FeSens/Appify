# frozen_string_literal: true
module Shopify
  class AfterAuthenticateJob < ActiveJob::Base
    attr_accessor :shop

    def perform(shop_domain:)
      @shop = Shop.find_by(shopify_domain: shop_domain)
      configure_store

      shop.with_shopify_session do
        @themes_id = ShopifyAPI::Theme.find(:all)
        @themes_id.each do |t|
          layout = ShopifyAPI::Asset.find('layout/theme.liquid', params: { theme_id: t.id })
          unless layout.value.include? "<link rel='manifest' href='#{manifest_url}'>"
            l = layout.value.split('<head>')[1]
            layout.value = "<head> <link rel='manifest' href='#{manifest_url}'> #{l}"
            layout.save
          end
          script_urls.each do |script_url|
            if layout.value.include? "<script type='text/javascript' async='' src='#{script_url}'></script>"
              next
            end

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
      shop.update(plan_name: s.plan_name, domain: s.domain, shop_name: s.shop_name)

    end
  end
end
