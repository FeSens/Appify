class SendPushesController < AuthenticatedController
  def create
    Push.all.each do |customer|
      message = {
        title: push_params[:title],
        body: push_params[:body],
        icon: icon
      }
      PushSenderJob.perform_later(customer, message)
    end
    redirect_to home_index_path
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
