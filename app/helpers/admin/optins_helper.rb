module Admin::OptinsHelper
  def optins_kind
    current_shop.optins.distinct.pluck(:kind)
  end

  def active_tab(tab, param, default: "push")
    return "active" if tab == (param || default)
  end
end
