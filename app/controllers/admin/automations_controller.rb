module Admin
  class AutomationsController < AuthenticatedController
    attr_accessor :automation
    def index 
      @automations = current_shop.campaigns.where("tag ilike ?", "%Automation::%").order(created_at: :desc)
    end

    def edit; end

    def new 
      @automation = current_shop.campaigns.new
    end

    def create
      @automation = current_shop.campaigns.create(campaing_params)
      redirect_to admin_automations_path
    end

    def update
      automation.update(campaing_params)
      redirect_to admin_automations_path
    end

    private

    def campaing_params
      c = params.require(:automation).permit(:name, :tag, :title, :body, :url, :release_date)
      c[:url] = UrlBuilder.call(params[:automation][:url], params[:automation][:name])
      c
    end
  end
end
