# frozen_string_literal: true
module Admin
  class AuthenticatedController < ApplicationController
    include ShopifyApp::Authenticated unless Rails.env.development?

    helper_method :current_shop
    after_action :set_activity, only: %i[index]

    private

    def current_shop
      @current_shop ||= begin
        if Rails.env.development?
          Shop.last
        else
          Shop.find(session[:shop_id])
        end
      end
    end

    def set_activity
      current_shop.touch(:last_activity)
    end
  end
end