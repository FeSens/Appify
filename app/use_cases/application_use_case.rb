# app/services/application_service.rb
require 'dry/monads'

class ApplicationUseCase
  def self.call(*args, &block)
    new(*args, &block).call
  end
end