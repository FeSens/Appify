module Demo
  class CampaignsController < DemoController
    def new
      # Send Push, pop up promter if now alloed
      @campaign = current_shop.campaigns.new
    end

    def create
      # Actually send push
    end
  end
end
