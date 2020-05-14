class SendPushesController < AuthenticatedController
  def create
    Push.all.each do |customer|
      message = {
        title: push_params[:title],
        body: push_params[:body],
        icon: icon
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

  private

  def push_params
    params.require(:push).permit(:title, :body, :icon)
  end

  def icon
    return push_params[:icon] if push_params[:icon].present?
    shop.manifest.icon.variant(resize_to_fit: [192, 192]).processed.service_url.sub(/\?.*/, '') if shop.manifest.icon.present?
  end

end
