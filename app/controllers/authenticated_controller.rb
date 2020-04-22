# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  include ShopifyApp::Authenticated

  private

  def shop
    Shop.where(shopify_domain: ShopifyAPI::Shop.current.myshopify_domain).first
  end

  def domain
    ShopifyAPI::Shop.current.domain
  end
end
