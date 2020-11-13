
module Pushes
  module Brokers
    class Jaiminho < Base
      attr_reader :sqs
      URL = Rails.application.config.jaminho_sqs
      BATCH_SIZE = 10 #Maximum allowed 

      def initialize
        @sqs = Aws::SQS::Client.new(
          region: 'us-east-1',
          access_key_id:  Rails.application.credentials.dig(:amazon, :api_key),
          secret_access_key: Rails.application.credentials.dig(:amazon, :api_secret_key)
        )
      end

      def deliver(customer, message, **args)
        @sqs.send_message(queue_url: URL, message_body: payload(customer, message))
      end

      def deliver_batch(customers, messages, **args)
        entries(customers, messages).each_slice(BATCH_SIZE).each do |entrie|
          sqs.send_message_batch({
            queue_url: URL,
            entries: entrie
          })
        end
      end

      def payload(customer, message)
        customer.attributes.merge({ message: message }).to_json
      end

      def entries(customers, messages)
        customers.zip(messages).map do |customer, message|
          {
            id: "#{customer.id}-#{message[:campaign_id]}",
            message_body: payload(customer, message)
          }
        end
      end
    end
  end
end
