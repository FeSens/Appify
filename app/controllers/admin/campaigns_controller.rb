module Admin
  class CampaignsController < AuthenticatedController
    before_action :load_campaign, only: %i[edit update destroy]
    after_action :create_job, only: %i[update create]
    attr_accessor :campaign

    def index
      @campaigns = current_shop.campaigns.order(release_date: :desc)
    end

    def new
      @campaign = current_shop.campaigns.new(duplicate_campaing_params)
    end

    def edit; end

    def update
      campaign.update(campaing_params)
      redirect_to admin_campaigns_path
    end

    def create
      @campaign = current_shop.campaigns.create(campaing_params)
      redirect_to admin_campaigns_path
    end

    def destroy
      @campaign.destroy
      redirect_to admin_campaigns_path
    end

    private

    def campaing_params
      c = params.require(:campaign).permit(:name, :tag, :title, :body, :url, :release_date)
      c[:url] = UrlBuilder.call(params[:campaign][:url], params[:campaign][:name])
      c
    end

    def duplicate_campaing_params
      c = params.permit(:name, :tag, :title, :body, :url, :release_date)
      c[:url] = UrlBuilder.call(params[:url], params[:name]) if params[:url].present?
      c[:release_date] = Time.now unless params[:release_date].present?
      c
    end

    def load_campaign
      @campaign = current_shop.campaigns.find(params[:id])
    end

    def create_job
      CreateCampaignJob.set(wait_until: campaign.release_date).perform_later(campaign, :all)
    end
  end
end
