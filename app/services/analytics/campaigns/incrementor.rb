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
        Campaign.increment_cached(column, campaign_id)
        return unless column == "impressions"
        
        push_interaction_id = Rails.cache.fetch("Analytics/Campaigns/Incrementor/#{shop_id}/#{Date.today.at_beginning_of_month}", expires_in: 60.seconds) do
          PushInteraction.find_or_create_by(shop_id: shop_id, date: Date.today.at_beginning_of_month).id
        end

        PushInteraction.increment_cached(:count, push_interaction_id)
      end
    end
  end
end
