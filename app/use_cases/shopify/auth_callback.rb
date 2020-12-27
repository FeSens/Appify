module Shopify
  # Performs login after OAuth completes
  class AuthCallback < ApplicationUseCase
    attr_reader :auth_hash, :session

    def initialize(auth, session)
      @auth_hash = auth
      @session = session
    end

    def call
      store_access_token_and_build_session
      perform_post_authenticate_jobs
    end

    private

    def respond_with_user_token_flow
      redirect_to(login_url_with_optional_shop)
    end

    def store_access_token_and_build_session
      set_shopify_session
    end

    def invalid_request?
      return true unless auth_hash
      false
    end

    def perform_post_authenticate_jobs
      install_webhooks
      install_scripttags
      perform_after_authenticate_job
    end

    def shop_name
      auth_hash.uid
    end

    def associated_user
      return unless auth_hash.dig('extra', 'associated_user').present?

      auth_hash['extra']['associated_user'].merge('scope' => auth_hash['extra']['associated_user_scope'])
    end

    def associated_user_id
      associated_user && associated_user['id']
    end

    def token
      auth_hash['credentials']['token']
    end

    def reset_session_options
      request.session_options[:renew] = true
      session.delete(:_csrf_token)
    end

    def set_shopify_session
      session_store = ShopifyAPI::Session.new(
        domain: shop_name,
        token: token,
        api_version: ShopifyApp.configuration.api_version
      )

      session[:shopify_user] = associated_user
      if session[:shopify_user].present?
        session[:shop_id] = nil
        session[:user_id] = ShopifyApp::SessionRepository.store_user_session(session_store, associated_user)
      else
        session[:shop_id] = ShopifyApp::SessionRepository.store_shop_session(session_store)
        session[:user_id] = nil
      end
      session[:shopify_domain] = shop_name
      session[:user_session] = auth_hash&.extra&.session
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
        job.perform_now(shop_domain: session[:shopify_domain])
      else
        job.perform_later(shop_domain: session[:shopify_domain])
      end
    end
  end
end