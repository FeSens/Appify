module Admin
  module ShopHelper
    def pushes_sent
      push = current_shop.push_interactions.last
      push&.count || 0
    end

    def app_installs
      @app_installs ||= number_to_human(current_shop.subscriber_counts.pwa.sum(:count))
    end

    def push_subscribers
      @push_subscribers ||= number_to_human(current_shop.pushes.count, precision: 4)
    end

    def shop_name
      return "Gustavo M." if Flipper['live-mode'].enabled?(current_shop)
      current_shop.name
    end

    def theme_verified?
      current_shop.theme_verified
    end

    def campaigns
      current_shop.campaigns
    end

    def campaigns_revenue
      @revenue ||= current_shop.campaigns.sum(:clicks) * current_shop.marketing_value.cpc
      number_to_currency(@revenue, precision: 0, locale: "pt-BR", unit: "R$")
    end

    def app_revenue
      @app_revenue ||= current_shop.subscriber_counts.pwa.sum(:count) * current_shop.marketing_value.cpd
      number_to_currency(@app_revenue, precision: 0, locale: "pt-BR", unit: "R$")
    end

    def campaign_revenue(campaign)
      number_to_currency(campaign.clicks * current_shop.marketing_value.cpc, locale: "pt-BR", unit: "R$")
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
