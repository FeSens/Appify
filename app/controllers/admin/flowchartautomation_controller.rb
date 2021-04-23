module Admin
  class FlowchartautomationController < AuthenticatedController
    def index; end

    def edit; end

    def new 
      @templates = current_shop.campaigns
    end

    def create; end

    def update; end

    def destroy; end
  end
end
