class PushesController < ApplicationController
  def create
    push_subscriber = Push.find_or_initialize_by(endpoint: subscription_params[:endpoint])
    push_subscriber = push_subscriber.update(subscription_params)

    return render json: { message: 'Subscription Failed' }, status: :unprocessable_entity unless push_subscriber

    render json: { message: 'Subscription Succeded' }
  end

  private

  def subscription_params
    params.permit(:endpoint, :auth, :p256dh, :shop)
  end
end
