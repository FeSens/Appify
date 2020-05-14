# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  include ShopifyApp::Authenticated

  private

  def shop
    Shop.find_by(shopify_domain: ShopifyAPI::Shop.current.myshopify_domain)
  end

  def domain
    ShopifyAPI::Shop.current.domain
  end
end
