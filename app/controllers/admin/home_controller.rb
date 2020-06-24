# frozen_string_literal: true

module Admin
  class HomeController < AuthenticatedController
    def index
      push = PushInteraction.find_or_create_by(shop_id: shop.id, date: Date.today.at_beginning_of_month)
      @push_interaction = { push_count: push.count, push_limit: shop.push_limit }
      @new_subscribers = shop.subscriber_counts.push.last_half.sum(:count)
      @push_subscribers = shop.pushes.count
      @campaigns = shop.campaigns
      @revenue = shop.orders.this_month.sum(:total)
    end
  end
end
