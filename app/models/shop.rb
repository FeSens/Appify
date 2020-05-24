# frozen_string_literal: true
class Shop < ActiveRecord::Base
  include ShopifyApp::ShopSessionStorage
  has_one :manifest, dependent: :destroy
  has_one :configuration, dependent: :destroy
  has_many :pushes, dependent: :destroy
  has_many :push_interactions, dependent: :destroy
  has_many :subscriber_counts, dependent: :destroy
  after_create :init_models

  def init_models
    create_manifest
    create_configuration
  end

  def api_version
    ShopifyApp.configuration.api_version
  end
end
