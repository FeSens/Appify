module Campaigns
  module Targeters
    class All < ApplicationService
      attr_accessor :shop_id
      def initialize(shop_id, args: nil)
        @shop_id = shop_id
        @args = args
      end

      def call
        Push.where(shop_id: shop_id)
      end
    end
  end
end
