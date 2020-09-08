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

    def campaigns
      current_shop.campaigns
    end

    def revenue
      @revenue ||= current_shop.orders.sum(:total)
      number_to_currency(@revenue)
    end

    def app_revenue
      @app_revenue ||= current_shop.campaigns.find_by(name:"app").orders.sum(:total)
      number_to_currency(@app_revenue)
    end

    def new_subscribers
      @new_subscribers ||= current_shop.subscriber_counts.push.last_half.sum(:count)
    end

    def push_interaction
      @push_interaction ||= begin
        push = PushInteraction.find_or_create_by(shop_id: current_shop.id, date: Date.today.at_beginning_of_month)
        { push_count: push.count, push_limit: current_shop.push_limit }
      end
    end

    def percentage_of_interactions_consumed
      100 * push_interaction[:push_count].to_f / push_interaction[:push_limit].to_f
    end
  end
end