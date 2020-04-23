class ManifestController < ApplicationController
  def index
    shop = Shop.first.find_by(domain: request.host)
    return render json: {} unless shop

    manifest = shop.manifest
    render json: manifest, except: %i[id created_at updated_at shop_id]
  end
end
