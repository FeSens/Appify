module Admin
  module Journey
    class InteractionsController < AuthenticatedController
      def index
        @interactions = current_shop.journeys.find(params[:journey_id])
      end
    end
  end
end