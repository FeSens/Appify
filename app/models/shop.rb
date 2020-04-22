# frozen_string_literal: true
class Shop < ActiveRecord::Base
  include ShopifyApp::ShopSessionStorage
  has_one :manifest

  def api_version
    ShopifyApp.configuration.api_version
  end
end
