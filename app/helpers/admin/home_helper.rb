module Admin::HomeHelper
  def app_installs(delta=0.days.ago)
    @app_installs = current_shop.subscriber_counts.where('date <= ?', delta).pwa.sum(:count)
  end

  def growth(a, b)
    ((a.to_i-b.to_i)/(b.to_f + 1e-5)).round(2)
  end

  #TODO: Move this to a badge
  def growth_badge(a, b)
    return "<span class='badge badge-soft-secondary p-1'>0.0</span>" if a == b

    g = a - b
    c = g >= 0 ? "success" : "danger"
    d = g >= 0 ? "up" : "down"
    
    "<span class='badge badge-soft-#{c} p-1'>
      <i class='tio-trending-#{d}'></i> #{number_to_human(g)}
    </span>"
  end

  def app_revenue_delta(delta=7.days.ago)
    app_revenue = current_shop.subscriber_counts.where('date >= ?', delta).pwa.sum(:count) * current_shop.marketing_value.cpd
    number_to_currency(app_revenue, precision: 0, locale: "pt-BR", unit: "R$")
  end

  def campaigns_revenue_delta(delta=7.days.ago)
    revenue = current_shop.campaigns.where('created_at >= ?', delta).sum(:clicks) * current_shop.marketing_value.cpc
    number_to_currency(revenue, precision: 0, locale: "pt-BR", unit: "R$")
  end

  def push_subscribers
    @push_subscribers = current_shop.pushes.count
  end

  def push_subscribers_delta(delta=7.days.ago)
    n = current_shop.subscriber_counts.push.where('created_at >= ?', delta).sum(:count) - current_shop.subscriber_counts.push_unsubscribed.where('created_at >= ?', delta).sum(:count)
    @push_subscribers_delta = current_shop.pushes.count - n
  end
end
