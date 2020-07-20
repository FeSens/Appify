# frozen_string_literal: true
module Admin
  class AuthenticatedController < ApplicationController
    include ShopifyApp::Authenticated

    if Rails.env.development?
      skip_before_action *_process_action_callbacks.map{|callback| callback.filter if callback.kind == :before}.compact
      skip_around_action *_process_action_callbacks.map{|callback| callback.filter if callback.kind == :around}.compact
      skip_after_action *_process_action_callbacks.map{|callback| callback.filter if callback.kind == :around}.compact
    end

    attr_accessor :shop
    before_action :load_current_shop
    after_action :set_activity, only: %i[index]
    helper_method :shop_name
    helper_method :theme_verified?

    private

    def load_current_shop
      return @shop = Shop.last if Rails.env.development?

      @shop = Shop.find(session[:shop_id])
    end

    def script_urls
      ['/apps/script/serviceworker-register.js',
       '/apps/script/public/preferences.js']
    end

    def manifest_url
      '/apps/script/public/manifest.json'
    end

    def shop_name
      shop.name
    end
    
    def theme_verified?
      shop.theme_verified
    end

    def set_activity
      shop.touch(:last_activity)
    end
    
  end
end