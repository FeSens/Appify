module Analytics::CampaignsHelper
  def campaigns_last_month_ctr
    (current_shop.campaigns.last_month.sum(:clicks)/(current_shop.campaigns.last_month.sum(:impressions) + 1e-5)).round(2)
  end
end
