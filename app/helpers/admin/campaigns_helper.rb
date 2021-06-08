module Admin::CampaignsHelper
  def campaign_title
    return "Titulo da notificação" unless @campaign.present?

    @campaign.title
  end

  def campaign_body
    return "Corpo da notificação" unless @campaign.present?

    @campaign.body
  end
end
