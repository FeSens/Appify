class Api::V1::Magazord::IconController < ApplicationController
  attr_reader :manifest
  before_action :load_manifest, only: :show

  def show
    image = get_image(params[:dim])

    send_data image.body, type: image.content_type, disposition: 'inline'
  end

  private

  def get_image(dim)
    uri = Rails.cache.fetch("Icons/#{params[:id]}", expires_in: 1.minute) do
      url = manifest.icon.variant(resize: dim).processed.service_url.sub(/\?.*/, '')
      escaped_address = URI.escape(url) 
      URI.parse(escaped_address)
    end

    Net::HTTP.get_response(uri)
  end

  def load_manifest
    @manifest = Rails.cache.fetch("Manifest/#{params[:id]}", expires_in: 1.minute) do
      Manifest.find_by(shop_id: params[:id])
    end

    return render json: { error: "Store not found" }, status: :unprocessable_entity unless manifest.present?
  end
end
