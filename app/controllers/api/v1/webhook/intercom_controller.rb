module Api
  module V1
    module Webhook
      class IntercomController < ActionController::API
        def create
          return head :no_content if params.dig("data", "item", "type") == "ping"
          Notifier::Intercom.call(intercom_params.to_h)

          head :no_content
        end

        private

        def intercom_params
          params.require(:data).permit(item: {})
        end
      end
    end
  end
end
