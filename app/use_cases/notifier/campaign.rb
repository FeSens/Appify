module Notifier
  class Campaign < Discord
    attr_accessor :campaign, :shop

    def initialize(campaign)
      super()
      @campaign = campaign
      @shop = campaign.shop
    end

    def call!
      client.execute do |builder|
        builder.content = "A loja #{shop.name} criou uma campanha!"
        builder.add_embed do |embed|
          embed.title = campaign.title
          embed.description = campaign.body
          embed.timestamp = campaign.release_date
          embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: campaign_image)
          embed.author = Discordrb::Webhooks::EmbedAuthor.new(
            name: shop.name, 
            url: shop.domain, 
            icon_url: shop_icon)
        end
      end
    end

    private

    def shop_icon
      shop.manifest.icon.url || default_image
    rescue URI::InvalidURIError => e
      default_image
    end

    def campaign_image
      campaign.image.url || default_image
    rescue URI::InvalidURIError => e
      default_image
    end

    def default_image
      "https://i.ytimg.com/vi/QH2-TGUlwu4/sddefault.jpg"
    end
  end
end
