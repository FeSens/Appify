module Shops
  class Shopify < ApplicationUseCase
    attr_reader :auth_hash, :session

    def initialize(auth, session)
      @auth_hash = auth
      @session = session
    end

    def call
      shop = Shop.create_with(shopify_token: token).find_or_create_by!(shopify_domain: shop_name)
      shop.update(shopify_token: token)
      perform_post_authenticate_jobs
      shop
    end

    private

    def perform_post_authenticate_jobs
      install_webhooks
      install_scripttags
      perform_after_authenticate_job
    end

    def shop_name
      auth_hash.uid
    end

    def token
      auth_hash['credentials']['token']
    end

    def install_webhooks
      return unless ShopifyApp.configuration.has_webhooks?

      ShopifyApp::WebhooksManager.queue(
        shop_name,
        token,
        ShopifyApp.configuration.webhooks
      )
    end

    def install_scripttags
      return unless ShopifyApp.configuration.has_scripttags?

      ScripttagsManager.queue(
        shop_name,
        token,
        ShopifyApp.configuration.scripttags
      )
    end

    def perform_after_authenticate_job
      config = ShopifyApp.configuration.after_authenticate_job

      return unless config && config[:job].present?

      job = config[:job]
      job = job.constantize if job.is_a?(String)

      if config[:inline] == true
        job.perform_now(shop_domain: shop_name)
      else
        job.perform_later(shop_domain: shop_name)
      end
    end
  end
end