module Public
  class ManifestController < PublicController
    helper_method :hash_color, :icon_sizes

    def index
      @manifest = shop.manifest
    end

    def hash_color(color)
      "##{color.gsub('#', '')}"
    end

    def icon_sizes
      ["192x192", "512x512"]
    end

  end
end
