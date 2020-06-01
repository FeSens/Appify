module Admin
  class SubscribersController < AuthenticatedController
    def index
      push_subs_base = SubscriberCount.where(['shop_id = ? and created_at < ?', shop.id, 14.days.ago]).push.count

      push = []
      push_new_subscribers = []
      subscriber_count.push.pluck(:count).each do |p|
        push <<  push_subs_base + push_new_subscribers.sum
        push_new_subscribers << p
      end

      subscriber_count = SubscriberCount.where(['shop_id = ? and created_at > ?', shop.id, 14.days.ago]).order(updated_at: :asc)
      render json: { pwa: subscriber_count.pwa.pluck(:count),
                    push: push,
                    push_new_subscribers: push_new_subscribers,
                    date_pwa: subscriber_count.pwa.pluck(:date),
                    date_push: subscriber_count.push.pluck(:date) }
    end
  end
end
