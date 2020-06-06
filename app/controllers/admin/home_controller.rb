# frozen_string_literal: true
module Admin
  class HomeController < AuthenticatedController
    def index
      #@manifest = shop.manifest
      #@configuration = shop.configuration
      push = PushInteraction.find_or_create_by(shop_id: shop.id, date: Date.today.at_beginning_of_month)
      @push_interaction = { push_count: push.count, push_limit: shop.push_limit }
      @new_subscribers = shop.subscriber_counts.push.last_half.count
      @push_subscribers = shop.pushes.count
      @campaigns = shop.campaigns
    end
  end
end
