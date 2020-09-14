module Analytics
  module Carts
    class Creator < ApplicationService
      attr_accessor :params
      attr_reader :subscriber_id, :shop_id

      def initialize(params, subscriber_id, shop_id)
        @params = params
        @subscriber_id = subscriber_id
        @shop_id = shop_id
      end
      
      def call
        call!
        true
      end

      def call!
        cart = Cart.find_or_initialize_by(token: params[:token])
        cart.update(cart_params)
      end

      private
  
      def cart_params
        params[:push_id] = push_id
        params[:impacted] = true if impacted?
        params
      end

      def push_id
        p = Push.find_by(subscriber_id: subscriber_id)
        return p.id if p.present?
        nil
      end

      def impacted?
        params['utm_source']&.include?('aplicatify')
      end
    end
  end
end
