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
      c = params.require(:campaign).permit(:name, :tag, :title, :body, :url, :release_date)
      c[:url] = build_url
      c
    end

    def load_campaign
      @campaign = shop.campaigns.find(params[:id])
    end

    def create_job
      CreateCampaignJob.set(wait_until: campaign.release_date).perform_later(campaign)
    end

    def build_url
      url = params[:campaign][:url].match(/^\/*(.*)/)&.captures&.first
      uri = URI.parse(url)
      q = uri.query.present? ? Rack::Utils.parse_nested_query(uri.query) : {}
      q["utm_source"] = "aplicatify"
      q["utm_medium"] = "push"
      q["utm_campaign"] = params[:campaign][:name]
      q["ref"] = "aplicatify"
      return "/#{uri.path}?#{q.to_query}"
    end
  end
end
