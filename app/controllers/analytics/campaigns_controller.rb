module Analytics
  class CampaignsController < AnalyticsController
    class ParamsValidator
      include ActiveModel::Validations
      AVAILABLE_ATTR = %w[clicks impressions].freeze
      attr_reader :data
      validates :attr, inclusion: { in: AVAILABLE_ATTR }, allow_blank: false
      validates :campaign_id, numericality: { only_integer: true }, allow_blank: false

      def initialize(data)
        @data = data
      end

      def read_attribute_for_validation(key)
        data[key]
      end
    end

    before_action :validate_params

    def create
      Analytics::Campaigns::Incrementor.call(shop.id, params[:campaign_id], params[:attr])

      head :no_content
    end

    def validate_params
      validator = ParamsValidator.new(params)
      return if validator.valid?

      render json: { errors: validator.errors }, status: :unprocessable_entity
    end
  end
end
