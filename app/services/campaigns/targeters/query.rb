module Campaigns
  module Targeters
    class Query < ApplicationService
      attr_accessor :shop_id, :args

      def initialize(shop_id, **args)
        @shop_id = shop_id
        @args = args
      end

      def call
        args[:query]
      end
    end
  end
end
