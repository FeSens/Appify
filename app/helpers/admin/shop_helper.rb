module Admin
  module ShopHelper
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

    def shop_name
      current_shop.name
    end
    
    def theme_verified?
      current_shop.theme_verified
    end
  end
end