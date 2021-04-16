class Api::V1::Magazord::LogoController < ApplicationController
  attr_reader :manifest
  before_action :load_manifest, only: :show

  def show
    icons = icon_sizes.map { |dim|  icon_dict (dim) } if manifest.icon.present?

    render json: icons
  end

  private

  def load_manifest
    @manifest = Manifest.find_by(shop_id: params[:id])

    return render json: { error: "Store not found" }, status: :unprocessable_entity unless manifest.present?
  end
  
  def icon_sizes
    %w[192x192 512x512]
  end

  def icon_dict(dim)
    {
      "src":  manifest.icon.variant(resize: dim).processed.service_url.sub(/\?.*/, ''),
      "sizes": dim,
      "type": manifest.icon.content_type
    }
  end
end
