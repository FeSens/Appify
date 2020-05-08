class ManifestController < ApplicationController
  attr_accessor :shop

  def index
    @shop = Shop.find_by(domain: request.host)
    return render json: {} unless shop

    manifest = shop.manifest.as_json except: %i[id created_at updated_at shop_id]
    manifest['icons'] = icons if shop.manifest.icon.present?
    manifest['background_color'] = hash_color(manifest['background_color'])
    manifest['theme_color'] = hash_color(manifest['theme_color'])
    render json: manifest
  end

  def icons
    sizes = [[192, 192], [512, 512]]
    sizes.map do |size|
      { src: shop.manifest.icon.variant(resize_to_fit: size).processed.service_url.sub(/\?.*/, ''),
        sizes: "#{size[0]}x#{size[1]}",
        type: icon.content_type
      }
    end
  end

  def hash_color(color)
    "##{color.gsub('#', '')}"
  end

end
