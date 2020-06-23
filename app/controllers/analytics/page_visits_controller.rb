module Analytics
  class PageVisitsController < AnalyticsController
    before_action :validate
    attr_accessor :shop

    def create
      params_recived = page_visit_params
      p = Push.find_by(subscriber_id: params[:subscriber_id])
      if p.present?
        PageVisit.where(subscriber_id: p.subscriber_id, push_id: nil).update(push_id: p.id)
        params_recived.merge(push_id: p.id)
      end

      PageVisit.create(params_recived)
      head :no_content
    end

    def page_visit_params
      params.permit(:path, :data, :time_spent, :subscriber_id, :session, :is_available)
    end

    def validate
      return @shop = Shop.last if Rails.env.development?

      @shop = Shop.find_by(domain: request.host)
      return head :no_content unless shop
    end
  end
end
