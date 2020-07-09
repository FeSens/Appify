# frozen_string_literal: true

class Shop < ApplicationRecord
  include ShopifyApp::ShopSessionStorage

  enum plan_name: { partner_test: 0, retainer: 1 }
  has_one :manifest, dependent: :destroy
  has_one :configuration, dependent: :destroy
  has_many :automations, dependent: :destroy
  has_many :pushes, dependent: :destroy
  has_many :push_interactions, dependent: :destroy
  has_many :subscriber_counts, dependent: :destroy
  has_many :campaigns, dependent: :destroy
  has_many :optins, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :page_visits, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :opt_in_counts, dependent: :destroy
  
  after_create :init_models

  def init_models
    create_manifest
    optins.create(kind: 'pwa',
                  title: 'Put our store in your pocket!',
                  body: 'Download our app and keep updated about your order and the newest products!',
                  accept_button: "Let's go!",
                  timer: 15)
    optins.create(kind: 'push')
    campaigns.create(name:"app", tag:"internal", url:"/?ref=aplicatify&utm_source=aplicatify&utm_medium=app&utm_campaign=app")
  end

  def api_version
    ShopifyApp.configuration.api_version
  end
end
