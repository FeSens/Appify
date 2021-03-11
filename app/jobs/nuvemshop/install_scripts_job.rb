class Nuvemshop::InstallScriptsJob < ApplicationJob
  queue_as :default

  def perform(shop)
    shop.with_nuvemshop_session do
      scripts = NuvemshopAPI::Scripts.all
      unless scripts.map { |a| a.src.match(/preferences/) }.any?
        script = NuvemshopAPI::Scripts.create(src:"https://app.vorta.com.br/public/preferences/#{shop.id}.js" , event:"onload", where:"store")
      end
    end
  end
end
