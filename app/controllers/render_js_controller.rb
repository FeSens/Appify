class RenderJsController < ApplicationController
  attr_accessor :shop
  skip_before_action :verify_authenticity_token

  def index
    @shop = Shop.last#Shop.find_by(domain: request.host)
  end
end
