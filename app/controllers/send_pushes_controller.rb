class SendPushesController < AuthenticatedController
  def create
    Push.all.each do |customer|
      message = {
        title: params[:title],
        body: params[:body]
      }
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
      true
    rescue Webpush::ExpiredSubscription
      customer.destroy
      false
    end
  end
end
