# app/services/tweet_creator.rb
class MostSeen
  attr_reader :shop, :campaign
  
  def initialize(shop)
    @shop = shop
  end

  def create(time)
    filter = shop.page_visits.where.not(push:nil)
    .where("time_spent > ? and is_available = true", time * 1000)
    .pluck(:push_id, :path)

    @campaign = shop.campaigns.create(campaing_params)
    CreateFilteredCampaingJob.set(wait_until: campaign.release_date).perform_later(campaign, filter)
  end

  def campaing_params
    { 
      name: "Automation Campaign Test",
      tag: "automation",
      title: "Não perca esta chance!",
      body: "Excelente escolha. Agora é só selecionar a cor, tamanho e clicar em Comprar agora!",
      release_date: Date.today
     }
  end
end