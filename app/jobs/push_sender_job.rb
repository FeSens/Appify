class PushSenderJob < ApplicationJob
  queue_as :default

  def perform(customer, message)
    send_push(customer, message)
  end

  def send_push(customer, message)
    Webpush.payload_send(
      endpoint: customer.endpoint,
      message: message.to_json,
      p256dh: customer.p256dh,
      auth: customer.auth,
      vapid: {
        subject: 'mailto:suporte@appify.com',
        public_key: Rails.application.credentials.dig(:webpush, :public_key),
        private_key: Rails.application.credentials.dig(:webpush, :private_key)
      }
    )
  rescue Webpush::ExpiredSubscription
    customer.destroy
  end
end
