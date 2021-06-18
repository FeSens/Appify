module Demo
  class CampaignsController < DemoController
    attr_accessor :campaign

    def new
      # Send Push, pop up promter if now alloed
      @campaign = current_shop.campaigns.new
    end

    def create
      @campaign = current_shop.campaigns.create(campaing_params)
      CreateCampaignJob.perform_later(campaign, :current, {push_id: params[:push_id]})
      # Actually send push
    end

    private

    def campaing_params
      c = params.require(:campaign).permit(:name, :tag, :title, :image, :body, :url, :release_date)
      c[:url] = UrlBuilder.call(params[:campaign][:url], params[:campaign][:name])
      c
    end
  end
end
