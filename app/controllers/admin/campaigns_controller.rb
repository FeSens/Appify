module Admin
  class CampaignsController < AuthenticatedController
    before_action :load_campaign, only: %i[edit update]
    after_action :create_job, only: %i[update create]
    attr_accessor :campaign
    def index
      @campaigns = shop.campaigns.order(created_at: :desc)
    end

    def new
      @campaign = shop.campaigns.new
    end

    def edit; end

    def update
      campaign.update(campaing_params)
      redirect_to admin_campaigns_path
    end

    def create
      @campaign = shop.campaigns.create(campaing_params)
      redirect_to admin_campaigns_path
    end

    private

    def campaing_params
      params.require(:campaign).permit(:name, :tag, :title, :body, :url, :release_date)
    end

    def load_campaign
      @campaign = shop.campaigns.find(params[:id])
    end

    def create_job
      CreateCampaignJob.set(wait_until: campaign.release_date).perform_later(campaign)
    end
  end
end
