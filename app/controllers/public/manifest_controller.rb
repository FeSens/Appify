module Public
  class ManifestController < PublicController
    def index
      Rails.cache.fetch("{ManifestController:#{shop.id}}", expires_in: 5.minutes) do
        manifest = shop.manifest.as_json except: %i[id created_at updated_at shop_id]
        manifest['icons'] = icons if shop.manifest.icon.present?
        manifest['background_color'] = hash_color(manifest['background_color'])
        manifest['theme_color'] = hash_color(manifest['theme_color'])
        render json: manifest
      end
    end

    def icons
      sizes = [[192, 192], [512, 512]]
      sizes.map do |size|
        { src: shop.manifest.icon.variant(resize_to_fit: size).processed.service_url.sub(/\?.*/, ''),
          sizes: "#{size[0]}x#{size[1]}",
          type: shop.manifest.icon.content_type }
      end
    end

    def hash_color(color)
      "##{color.gsub('#', '')}"
    end
  end
end
