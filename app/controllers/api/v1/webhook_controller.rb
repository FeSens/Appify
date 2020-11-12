module Api
  module V1
    class WebhookController < ApiController
      SCOPE = ["webhook/create"]
      PLATAFORM = ["shopify"]
      TOPIC = ["push/create"]
      
      def index
        webhooks = ::Webhook.where.not(shop: nil).where(emitter: webhook.emitter)
        render json: webhooks, each_serializer: WebhookSerializer, status: :ok
      end

      def create
        attributes = validate_params(WebhookContracts::Create.new, params.to_unsafe_hash)
        raise ValidationExeption, "Plataform not supported" unless PLATAFORM.include?(attributes[:plataform])
        raise ValidationExeption, "Topic not supported" unless TOPIC.include?(attributes[:topic])

        shop = Shop.find_by!(shopify_domain: attributes[:identifier])
        new_webhook = ::Webhook.find_or_initialize_by(shop_id: shop.id, emitter: webhook.emitter, scope: [attributes[:topic]])
        new_webhook.token = SecureRandom.urlsafe_base64(48)

        shop.campaigns.create(name: "Integração #{webhook.emitter}", tag: "integration-#{webhook.emitter}") unless new_webhook.persisted?

        new_webhook.save!

        render json: { url: api_v1_webhook_push_url, token: new_webhook.token }, status: :ok
      end
    end
  end
end
