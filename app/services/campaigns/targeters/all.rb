module Campaigns
  module Targeters
    class All
      attr_accessor :shop_id
      def initialize(shop_id: nil)
      @shop_id = shop_id
      end

      def call
        Push.where(shop_id: shop_id)
      end
    end
  end
end
