module Api
  module V1
    module Webhook
      class PushSenderController < ApiController
        SCOPE = ["send_push"]
        
        def create
          attributes = validate_params(PushContracts::Create.new, params.to_unsafe_hash)
          send_push_job(attributes)
          head :no_content
        end

        private

        def send_push_job(attributes)
          push = Push.find_by!(subscriber_id: attributes[:subscriber_id], shop: current_shop)
          # TODO: Create Job
        end
      end
    end
  end
end
