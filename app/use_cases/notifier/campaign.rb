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
      return "https://media.nature.com/lw800/magazine-assets/d41586-020-01430-5/d41586-020-01430-5_17977552.jpg" unless Rails.env.production?
      
      shop.manifest.icon.url
    end

    def campaign_image
      return "https://media.nature.com/lw800/magazine-assets/d41586-020-01430-5/d41586-020-01430-5_17977552.jpg" unless Rails.env.production?
      
      campaign.image.url
    end
  end
end
