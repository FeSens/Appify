class Api::V1::ApiController < ActionController::API
  include ActionView::Layouts
  include ActionController::HttpAuthentication::Token::ControllerMethods

  layout "api/v1/application"

  before_action :authenticate
  
  class ValidationExeption < StandardError; end
  class InvalidAuthenticityToken < StandardError; end
  class NotEngouthPermissions < StandardError; end

  rescue_from ValidationExeption, with: :unprocessable_entity
  rescue_from ActiveRecord::RecordNotFound, with: :unprocessable_entity
  rescue_from InvalidAuthenticityToken, with: :unauthorized
  rescue_from NotEngouthPermissions, with: :forbidden

  SCOPE = []

  private

  attr_reader :webhook
  
  def authenticate
    authenticate_with_http_token do |token|
      @webhook = Webhook.find_by(token: token)
    end
    raise InvalidAuthenticityToken, "Invalid Authenticity Token" unless webhook
    raise InvalidAuthenticityToken, "Not enough premissions to make this action" unless validate_scope
  end

  def current_shop
    @current_shop ||= webhook.shop
  end

  def validate_scope
    self.class::SCOPE.all? { |scope| webhook.scope.include?(scope) }
  end

  def validate_params(contract, params)
    validation = contract.call(params)
    return validation.to_h if validation.success?

    raise ValidationExeption.new(validation.errors(full: true).messages.to_sentence)
  end

  def forbidden(exception=nil)
    base_response(:forbidden, exception)
  end

  def unauthorized(exception=nil)
    base_response(:unauthorized, exception)
  end

  def bad_request
    render status: :bad_request
  end

  def not_found
    render status: :not_found
  end

  def unprocessable_entity(exception=nil)
    base_response(:unprocessable_entity, exception)
  end

  def base_response(status, exception=nil)
    return render status: status if exception.blank?

    response = { 
      error: {
        status: Rack::Utils.status_code(status),
        message: exception.message
      }
     }
    render json: response, status: status
    
  end
end
