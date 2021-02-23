module Analytics::CampaignsHelper
  def campaigns_this_week_ctr
    (current_shop.campaigns.released_this_week.sum(:clicks)*100.0/(current_shop.campaigns.released_this_week.sum(:impressions) + 1e-5)).round(2)
  end

  def campaigns_last_week_ctr
    (current_shop.campaigns.released_last_week.sum(:clicks)*100.0/(current_shop.campaigns.released_last_week.sum(:impressions) + 1e-5)).round(2)
  end

  def calendar_events
    event = []
    @campaigns.each do |campaign|
      event << {
        title: campaign.name,
        start: campaign.release_date.to_formatted_s(:db),
        description: campaign.title
      }
    end

    return event.to_json
  end
end
