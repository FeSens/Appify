module Campaigns
  module Targeters
    class Current < ApplicationService
      attr_accessor :shop_id, :args
      def initialize(shop_id, **args)
        @shop_id = shop_id
        @args = args
      end

      def call
        Push.where(shop_id: shop_id, id: args[:push_id])
      end
    end
  end
end
