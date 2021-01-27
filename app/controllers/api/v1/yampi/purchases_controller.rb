module Api
  module V1
    module Yampi
      class PurchasesController < ApiController
        skip_before_action :authenticate

        def create
          push = Push.find_by(subscriber_id: params[:subscriber_id])
          Purchase.create(push_id: push.id)
          
          head :no_content
        end
      end
    end
  end
end
