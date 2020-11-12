module Api
  module V1
    module Webhook
      class PushesController < ApiController
        SCOPE = ["push/create"]
        
        attr_reader :attributes
        def create
          @attributes = validate_params(PushContracts::Create.new, params.to_unsafe_hash)
          send_push_job

          head :no_content
        end

        private

        def send_push_job
          push = Push.find_by!(subscriber_id: attributes[:subscriber_id], shop_id: current_shop.id)
          campaign = current_shop.campaigns.find_by(tag: "integration-#{webhook.emitter}")
          url = UrlBuilder.call(attributes[:url], campaign.name)
          message = Pushes::MessageBuilder.call(campaign, attributes[:message], url, title: attributes[:title])
          PushSenderJob.perform_later(push, message)
        end
      end
    end
  end
end
