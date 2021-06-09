module Analytics
  class CampaignsController < AnalyticsController
    def create
      Analytics::Campaigns::Incrementor.call(shop.id, params[:campaign_id], params[:attr])

      head :no_content
    end
  end
end
