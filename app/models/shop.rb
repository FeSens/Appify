# frozen_string_literal: true

class Shop < ApplicationRecord
  has_one :manifest, dependent: :destroy
  has_one :configuration, dependent: :destroy
  has_one :marketing_value, dependent: :destroy
  has_many :user, dependent: :destroy
  has_many :pushes, dependent: :destroy
  has_many :push_interactions, dependent: :destroy
  has_many :subscriber_counts, dependent: :destroy
  has_many :campaigns, dependent: :destroy
  has_many :optins, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :page_visits, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :opt_in_counts, dependent: :destroy
  has_many :webhooks, dependent: :destroy

  belongs_to :plan, optional: true

  before_create :generate_random_id
  after_create :init_models
  after_create :create_optins

  def init_models
    create_manifest(name: self.name, short_name: self.name)
    create_marketing_value(cpc: 0.446, cps: 1.78, cpd: 3.47)
    campaigns.create(
      name: "app",
      tag: "internal",
      url: "/?ref=aplicatify&utm_source=aplicatify&utm_medium=app&utm_campaign=app"
    )
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

  private

  def generate_random_id
    begin
      self.id = SecureRandom.random_number(9223372036854775807)
    end while Shop.where(id: self.id).exists?
  end

  def create_optins
    optins.create(kind: "pwa",
      title: "Coloque a nossa loja no seu bolso!",
      body: "Baixe o nosso App e fique por dentro de tudo!",
      accept_button: "Sim",
      timer: 90)
    optins.create(kind: "push")

    if type == "Shop::Devise"
      optins.create(kind: "page",
        title: "Tudo pronto para uma nova experiência de compra",
        background_color: "FFFFFF")
    end
  end
  
end
