module Admin::OptinsHelper
  def optins_kind
    if current_shop.type == "Shop::Shopify"
      return current_shop.optins.distinct.where.not(kind: :pwa).pluck(:kind)
    end
    current_shop.optins.distinct.pluck(:kind)
  end

  def active_tab(tab, param, default: "push")
    return "active" if tab == (param || default)
  end
end
