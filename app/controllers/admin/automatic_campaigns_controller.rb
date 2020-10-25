module Admin
  class AutomaticCampaignsController < AuthenticatedController
    before_action :load_automatic_campaign, only: %i[edit update]
    after_action :create_job, only: %i[update create]
    attr_accessor :automatic_campaign

    def index
      @campaigns = current_shop.automatic_campaigns.order(created_at: :desc)
    end

    def new
      @campaign = current_shop.automatic_campaigns.new
    end

    def edit; end

    def update
      campaign.update(automatic_ampaing_params)
      redirect_to admin_automatic_campaigns_path
    end

    def create
      @campaign = current_shop.automatic_campaigns.create(automatic_campaing_params)
      redirect_to admin_automatic_campaigns_path
    end

    private

    def automatic_campaing_params
      params.require(:campaign).permit(:name, :type, :config)
    end

    def load_automatic_campaign
      @campaign = current_shop.campaigns.find(params[:id])
    end

    def create_job
      raise NotImplementedError
    end
  end
end
