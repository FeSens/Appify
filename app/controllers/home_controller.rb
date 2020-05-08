# frozen_string_literal: true

class HomeController < AuthenticatedController
  def index
    @manifest = shop.manifest
    shop.update(domain: domain)
    regiter_script
  end

  private

  def regiter_script
    @themes_id = ShopifyAPI::Theme.find(:all)
    @themes_id.each do |t|
      layout = ShopifyAPI::Asset.find('layout/theme.liquid', :params => {:theme_id => t.id})
      unless layout.value.include? "<link rel='manifest' href='#{manifest_url}'>"
        l = layout.value.split("<head>")[1]
        layout.value = "<head> <link rel='manifest' href='#{manifest_url}'> #{l}"
        layout.save
      end
      unless layout.value.include? "<script type='text/javascript' async='' src='#{script_url}'></script>"
        l = layout.value.split("<head>")[1]
        layout.value = "<head> <script type='text/javascript' async='' src='#{script_url}'></script> #{l}"
        layout.save
      end
    end
  end

  def script_url
    '/apps/script/serviceworker-register.js'
  end

  def manifest_url
    '/apps/script/manifest.json'
  end
end
