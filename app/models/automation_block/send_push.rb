class AutomationBlock::SendPush < AutomationBlock
  store :settings, accessors: [:campaign_id], coder: JSON

  def run
    Campaigns::Creator(self.campaign, :query, query: pushes)
    super
  end

  def campaign=(object)
    self.campaign_id = object.id
  end

  def campaign
    Campaign.find(campaign_id)
  end
end