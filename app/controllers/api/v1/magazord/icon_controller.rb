class Api::V1::Magazord::IconController < ApplicationController
  attr_reader :manifest

  def show
    @manifest = Manifest.find_by(shop_id: params[:id])
    image = get_image(params[:dim])

    send_data image.body, type: image.content_type, disposition: 'inline'
  end

  private

  def get_image(dim)
      url = manifest.icon.variant(resize: dim).processed.service_url.sub(/\?.*/, '')
      Net::HTTP.get_response(url)
    end
  end
end
