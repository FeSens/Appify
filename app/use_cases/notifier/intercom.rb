module Notifier
  class Intercom < Discord
    attr_accessor :data, :topic, :created_at

    def initialize(data)
      super()
      @data = data["item"]
    end

    def call!
      client.execute do |builder|
        builder.username = "Intercom"
        builder.add_embed do |embed|
          embed.title = "Um usuário está conversando com você!"
          embed.url = data.dig("links", "conversation_web")
          embed.timestamp = timestamp
          embed.add_field(name: "Remetente", value: data.dig("user", "name"))
          embed.add_field(name: "Mensagem", value: message)
          embed.add_field(name: "Enviado por", value: author)
        end
      end
    end

    private

    def message_raw
      count = data.dig("conversation_parts", "total_count") || 0
      return data.dig("conversation_parts", "conversation_parts")&.last if count > 0

      data.dig("conversation_message")
    end

    def message
      message_raw["body"].gsub(/<(.|\n)*?>/, '')
    end

    def timestamp
      Time.at(message_raw["notified_at"] || Time.now)
    end

    def author
      message_raw.dig("author", "name") || "Autor Desconhecido"
    end
  end
end
