class PushSenderJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: 3
  retry_on ::OutOfPushInteractionsError # defaults to 3s wait, 5 attempts
  discard_on ActiveJob::DeserializationError
  discard_on ::ArgumentError

  def perform(customer, message)
    send_push(customer, message)
  end

  def send_push(customer, message)
    push_interaction = PushInteraction.find_or_create_by(shop_id: customer.shop_id, date: Date.today.at_beginning_of_month)
    push_interaction.autorized?
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
    push_interaction.decrement

  rescue Exception => e
    push_interaction.decrement
    raise
  end
end
