module Pushes
  class Sender < ApplicationService
    attr_reader :customer, :message

    def initialize(customer, message)
      @customer = customer
      @message = message
    end

    def call
      call! if Rails.env.production?
    rescue Webpush::ExpiredSubscription, Webpush::Unauthorized
      customer.destroy
    end

    def call!
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
