module Analytics
  module Campaigns
    class Incrementor < ApplicationService
      attr_reader :campaign_id, :column, :shop_id

      def initialize(shop_id, campaign_id, column)
        @shop_id = shop_id
        @campaign_id = campaign_id
        @column = column
      end

      def call
        Campaign.increment_counter column, campaign_id
        return unless column == "impressions"

        PushInteraction.find_or_create_by(shop_id: shop_id, date: Date.today.at_beginning_of_month).increment
      end
    end
  end
end
