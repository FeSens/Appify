module Admin
  class SubscribersController < AuthenticatedController
    def index
      subscriber_count = SubscriberCount.where(['shop_id = ? and created_at > ?', shop.id, 14.days.ago]).order(updated_at: :asc)
      render json: { pwa: subscriber_count.pwa.pluck(:count),
                    push: subscriber_count.push.pluck(:count),
                    date_pwa: subscriber_count.pwa.pluck(:date),
                    date_push: subscriber_count.push.pluck(:date) }
    end
  end
end