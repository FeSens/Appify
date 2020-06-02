# frozen_string_literal: true
module Admin
  class AuthenticatedController < ApplicationController
    include ShopifyApp::Authenticated

    if Rails.env.development?
      skip_before_action *_process_action_callbacks.map{|callback| callback.filter if callback.kind == :before}.compact if Rails.env.development?
      skip_around_action *_process_action_callbacks.map{|callback| callback.filter if callback.kind == :around}.compact if Rails.env.development?
      skip_after_action *_process_action_callbacks.map{|callback| callback.filter if callback.kind == :around}.compact if Rails.env.development?
    end

    attr_accessor :shop
    before_action :load_current_shop
    helper_method :shop_name

    private

    def store_configuration
      shop.update(plan_name: plan_name)
      shop.update(domain: domain)
    end

    def register_script
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

    def load_current_shop
      return @shop = Shop.last if Rails.env.development?

      @shop = Shop.find(session[:shop_id])
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

    def script_urls
      ['/apps/script/serviceworker-register.js',
       '/apps/script/public/preferences.js']
    end

    def manifest_url
      '/apps/script/public/manifest.json'
    end
  end
end