module Admin
  class AutomationsController < AuthenticatedController
    attr_accessor :campaign
    def index 
      @campaigns = current_shop.campaigns.where("tag ilike ?", "%Automation::%").order(created_at: :desc)
    end

    def edit; end

    def new 
      @campaign = current_shop.campaigns.new
    end

    def create
      @campaign = current_shop.campaigns.create(campaing_params)
      redirect_to admin_automations_path
    end

    def update
      campaign.update(campaing_params)
      redirect_to admin_automations_path
    end

    private

    def campaing_params
      c = params.require(:campaign).permit(:name, :tag, :title, :body, :url, :release_date)
      c[:url] = UrlBuilder.call(params[:campaign][:url], params[:campaign][:name])
      c
    end
  end
end
