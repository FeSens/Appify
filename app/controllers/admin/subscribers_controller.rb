module Admin
  class SubscribersController < AuthenticatedController
    def index
      #TODO Move this logic to a service
      push_subs_base = SubscriberCount.where(['shop_id = ? and created_at < ?', current_shop.id, 14.days.ago]).push.count
      subscriber_count = SubscriberCount.where(['shop_id = ? and created_at > ?', current_shop.id, 14.days.ago]).order(updated_at: :asc)

      push = []
      push_new_subscribers = []
      subscriber_count.push.pluck(:count).each do |p|
        push << push_subs_base + push_new_subscribers.sum
        push_new_subscribers << p
      end

      render json: { pwa: subscriber_count.pwa.pluck(:count),
                     push: push,
                     push_new_subscribers: push_new_subscribers,
                     date_pwa: subscriber_count.pwa.pluck(:date),
                     date_push: subscriber_count.push.pluck(:date) }
    end
  end
end
