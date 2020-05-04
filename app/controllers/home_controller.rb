# frozen_string_literal: true

class HomeController < AuthenticatedController
  def index
    @manifest = Manifest.last #shop.manifest
    shop.update(domain: domain)
    regiter_script
  end

  private

  def regiter_script
    @themes_id = ShopifyAPI::Theme.find(:all)
    @themes_id.each do |t|
      layout = ShopifyAPI::Asset.find('layout/theme.liquid', :params => {:theme_id => t.id})
      unless layout.value.present? "<link rel='manifest' href='apps/script/manifest.json'>"
        l = layout.value.split("<head>")[1]
        layout.value = "<head> <link rel='manifest' href='apps/script/manifest.json'> #{l}"
        layout.save
      end
    end
    @scripttags = ShopifyAPI::ScriptTag.find(:all)
    return nil if @scripttags.select { |i| i.src.include? script_url}.present?

    ShopifyAPI::ScriptTag.create(event: "onload", src: script_url)
    @scripttags = ShopifyAPI::ScriptTag.find(:all)
  end

  def script_url
    "https://#{domain}/apps/script/serviceworker-register.js"
  end
end
