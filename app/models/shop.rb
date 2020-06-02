# frozen_string_literal: true

class Shop < ActiveRecord::Base
  include ShopifyApp::ShopSessionStorage

  enum plan_name: %i[partner_test Basico]
  has_one :manifest, dependent: :destroy
  has_one :configuration, dependent: :destroy
  has_many :pushes, dependent: :destroy
  has_many :push_interactions, dependent: :destroy
  has_many :subscriber_counts, dependent: :destroy
  has_many :campaigns, dependent: :destroy
  has_many :optins, dependent: :destroy
  after_create :init_models

  def init_models
    self.optins.create(kind: 'pwa',
      title: "Put our store in your pocket!", body: "Download our app and keep updated about your order and the newest products!",
      accept_button: "Let's go!", timer: 15)
    self.optins.create(kind: 'push')

    self.create_manifest(name: shop_name, short_name: shop_name)
  end

  def api_version
    ShopifyApp.configuration.api_version
  end
  
  def shop_name
    return 'Loja Teste' if Rails.env.development?

    ShopifyAPI::Shop.current.name
  end
end
