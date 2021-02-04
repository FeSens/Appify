module Public
  class ManifestController < PublicController
    helper_method :hash_color, :icon_sizes

    def index
      @manifest = shop.manifest
    end

    def show
      @manifest = Manifest.find_by(shop_id: params[:id])
    end

    def hash_color(color)
      "##{color.delete("#")}"
    end

    def icon_sizes
      %w[192x192 512x512]
    end
  end
end
