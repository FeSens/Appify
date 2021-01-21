# frozen_string_literal: true

class Shop < ApplicationRecord
  has_one :manifest, dependent: :destroy
  has_one :configuration, dependent: :destroy
  has_one :marketing_value, dependent: :destroy

  has_many :user, dependent: :nullify
  has_many :pushes, dependent: :destroy
  has_many :push_interactions, dependent: :destroy
  has_many :subscriber_counts, dependent: :destroy
  has_many :campaigns, dependent: :destroy
  has_many :optins, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :page_visits, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :opt_in_counts, dependent: :destroy
  has_many :automatic_campaigns, dependent: :destroy
  has_many :webhooks, dependent: :destroy

  belongs_to :plan, optional: true

  after_create :init_models

  def init_models
    create_manifest(name: self.name, short_name: self.name)
    optins.create(kind: "pwa",
                  title: "Put our store in your pocket!",
                  body: "Download our app and keep updated about your order and the newest products!",
                  accept_button: "Let's go!",
                  timer: 15)
    optins.create(kind: "push")
    campaigns.create(
      name: "app",
      tag: "internal",
      url: "/?ref=aplicatify&utm_source=aplicatify&utm_medium=app&utm_campaign=app"
    )
    create_marketing_value(cpc: 0.27, cps: 2.50, cpd: 3.50)
  end

  def custom_data
    as_json(with_everything: true,
            except: %i[id name created_at updated_at last_auth last_activity shopify_token metadata push_limit]).merge(
              pushes_sent: push_interactions.last&.count || 0,
              last_auth: last_auth.to_i,
              last_activity: last_activity.to_i,
              campaigns_count: campaigns.count,
              app_installs: subscriber_counts.pwa.sum(:count),
              push_subscribers: pushes.count,
              pushes_limit: push_limit,
              opt_in_push_enabled: optins.push.first.enabled?,
              opt_in_pwa_enabled: optins.pwa.first.enabled?,
              app_icon: manifest.icon.present?
            )
  end
end
