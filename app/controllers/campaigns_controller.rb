class CampaignsController < AuthenticatedController
  def index
    @campaigns = shop.campaigns.order(created_at: :desc)
  end

  def new
    @campaign = shop.campaigns.new
  end

  def create
    campaign = shop.campaigns.create(campaing_params)
    CreateCampaignJob.set(wait_until: campaign.release_date).perform_later(campaign)
    redirect_to campaigns_path
  end

  private

  def campaing_params
    params.require(:campaign).permit(:name, :tag, :title, :body, :url, :release_date)
  end
end