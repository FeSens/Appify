class Api::V1::Magazord::LogoController < ApplicationController
  attr_reader :manifest
  before_action :load_manifest, only: :show

  def show
    icons = []
    icons = Rails.cache.fetch("Logo/#{params[:dim]}/#{params[:id]}", expires_in: 1.minute) do
      icon_sizes.map { |dim|  icon_dict (dim) } if manifest.icon.present?
    end

    render json: icons
  end

  private

  def load_manifest
    @manifest = Rails.cache.fetch("Manifest/#{params[:id]}", expires_in: 1.minute) do
      Manifest.find_by(shop_id: params[:id])
    end

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
