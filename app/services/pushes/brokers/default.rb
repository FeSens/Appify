module Pushes
  module Brokers
    class Default < Base
      THREAD_POOL_SIZE = 100 #Number of threads

      def deliver(customer, message, **args)
        call(customer, message)
      end

      def deliver_batch(customers, messages, **args)
        pool = Concurrent::FixedThreadPool.new(THREAD_POOL_SIZE)
        customers.zip(messages).map do |customer, message|
          pool.post do
            call(customer, message)
          end
        end
        pool.shutdown
        pool.wait_for_termination
      end
    
      def call(customer, message, **args)
        call!(customer, message) if Rails.env.production?
      rescue Webpush::ExpiredSubscription, Webpush::Unauthorized
        customer.destroy
      end

      def call!(customer, message)
        Webpush.payload_send(
          endpoint: customer.endpoint,
          message: message.to_json,
          p256dh: customer.p256dh,
          auth: customer.auth,
          vapid: {
            subject: "mailto:suporte@appify.com",
            public_key: Rails.application.credentials.dig(:webpush, :public_key),
            private_key: Rails.application.credentials.dig(:webpush, :private_key)
          }
        )
      end
    end
  end
end
