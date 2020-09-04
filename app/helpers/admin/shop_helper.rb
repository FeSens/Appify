module Admin
  module ShopHelper
    def current_shop
      return @shop = Shop.last if Rails.env.development?

      @shop = Shop.find(session[:shop_id])
    end

    def pushes_sent
      push = current_shop.push_interactions.last
      push&.count || 0
    end

    def app_installs
      current_shop.subscriber_counts.pwa.sum(:count)
    end

    def push_subscribers
      current_shop.pushes.count
    end
  end
end