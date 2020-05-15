class SubscriberCountController < ApplicationController
  def show
    subscriber_count = SubscriberCount.where(['shop_id = ? and created_at > ?', params[:id], 30.days.ago])
    render json: { pwa: subscriber_count.pwa.pluck(:count),
                   push: subscriber_count.push.pluck(:count),
                   date_pwa: subscriber_count.pwa.pluck(:date),
                   date_push: subscriber_count.push.pluck(:date) }
  end

  def create
    subscriber_count = SubscriberCount.find_or_create_by(subscriber_params)
    subscriber_count.increment(:count)
    subscriber_count.save
  end

  private

  def subscriber_params
    s = Shop.find_by(shopify_domain: params[:shop])
    params.permit(:service).merge(shop_id: s.id, date: Date.today)
  end
end
