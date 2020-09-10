module Campaigns
  module Targeters
    class All
      def call
        Push.where(shop_id: campaign.shop_id)
      end
    end
  end
end
