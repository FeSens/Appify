class RenderJsController < ApplicationController
  attr_accessor :shop
  skip_before_action :verify_authenticity_token

  def index
    @config = Shop.find_by(domain: request.host)&.configuration
    @config = Shop.last.configuration if Rails.env.development?
  end
end
