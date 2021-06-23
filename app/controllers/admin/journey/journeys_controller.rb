module Admin
  module Journey
    class JourneysController < AuthenticatedController
      def index
        @journeys = current_shop.journeys
      end
    end
  end
end