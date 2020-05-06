class ManifestController < ApplicationController
  def index
    shop = Shop.find_by(domain: request.host)
    return render json: {} unless shop

    manifest = shop.manifest.as_json except: %i[id created_at updated_at shop_id]
    manifest['icons'] = [shop.manifest.icon.service_url.sub(/\?.*/, '')] if shop.manifest.icon.present?
    render json: manifest
  end
end
