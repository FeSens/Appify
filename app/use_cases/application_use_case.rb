# app/services/application_service.rb
class ApplicationUseCase
  def self.call(*args, &block)
    new(*args, &block).call
  end
end