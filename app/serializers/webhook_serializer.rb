# frozen_string_literal: true

class WebhookSerializer < ApplicationSerializer
  attributes :shop, :scope, :token, :emitter, :updated_at

  def scope
    object&.scope.join(", ")
  end

  def shop
    object&.shop.shopify_domain
  end
end
