module Admin
  module Journey
    class InteractionsController < AuthenticatedController
      def index
        binding.pry
        @interactions = current_shop.journeys.find(params[:journey_id])
      end
    end
  end
end