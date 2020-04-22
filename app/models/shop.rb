# frozen_string_literal: true
class Shop < ActiveRecord::Base
  include ShopifyApp::ShopSessionStorage
  has_one :manifest
  after_create :init_manifest

  def init_manifest
    create_manifest
  end

  def api_version
    ShopifyApp.configuration.api_version
  end
end
