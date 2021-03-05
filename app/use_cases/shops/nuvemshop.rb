module Shops
  class Nuvemshop < ApplicationUseCase
    attr_reader :auth_hash, :session
    attr_accessor :shop

    def initialize(auth, session)
      @auth_hash = auth
      @session = session
    end

    def call
      @shop = Shop::Nuvemshop.create_with(shopify_token: token).find_or_create_by!(shopify_domain: shop_name)
      shop.update(shopify_token: token)
      perform_post_authenticate_jobs
      shop
    end

    private

    def perform_post_authenticate_jobs
      #install_webhooks
      install_scripttags
      perform_after_authenticate_job
    end

    def shop_name
      auth_hash.uid
    end

    def token
      auth_hash['credentials']['token']
    end

    def install_webhooks ; end

    def install_scripttags ; end

    def perform_after_authenticate_job

    end
  end
end