# frozen_string_literal: true
class Shop < ActiveRecord::Base
  include ShopifyApp::ShopSessionStorage
  has_one :manifest, dependent: :destroy
  has_one :configuration, dependent: :destroy
  after_create :init_manifest

  def init_manifest
    create_manifest
    create_configuration
  end

  def api_version
    ShopifyApp.configuration.api_version
  end
end
