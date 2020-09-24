# frozen_string_literal: true
module Admin
  class AuthenticatedController < ApplicationController
    include ShopifyApp::Authenticated if Rails.env.production?

    helper_method :current_shop
    after_action :set_activity, only: %i[index]

    private

    def current_shop
      @current_shop ||= begin
        return Shop.last unless Rails.env.production?
        
        Shop.find(session[:shop_id])
      end
    end

    def set_activity
      current_shop.touch(:last_activity)
    end
  end
end