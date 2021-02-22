module Analytics::CampaignsHelper
  def campaigns_this_week_ctr
    (current_shop.campaigns.released_this_week.sum(:clicks)*100.0/(current_shop.campaigns.released_this_week.sum(:impressions) + 1e-5)).round(2)
  end

  def campaigns_last_week_ctr
    (current_shop.campaigns.released_last_week.sum(:clicks)*100.0/(current_shop.campaigns.released_last_week.sum(:impressions) + 1e-5)).round(2)
  end
end
