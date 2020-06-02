# frozen_string_literal: true
module Shopify
  class AfterAuthenticateJob < ActiveJob::Base
    def perform(shop_domain:)
      shop = Shop.find_by(shopify_domain: shop_domain)
      shop.update(plan_name: plan_name)
      shop.update(domain: domain)

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

    def shop_name
      return 'Loja Teste' if Rails.env.development?

      ShopifyAPI::Shop.current.name
    end

    def plan_name
      ShopifyAPI::Shop.current.plan_name
    end

    def domain
      ShopifyAPI::Shop.current.domain
    end
  end
end