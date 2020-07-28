module Admin
  class AutomationsController < AuthenticatedController
    def index
      @automations = []
      @automations << shop.automations.find_or_create_by(kind: "cart recovery")
    end

    def edit

    end

    def update

    end
  end
end
