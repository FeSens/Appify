class PushSenderJob < ApplicationJob
  queue_as :critical
  sidekiq_options retry: 3
  discard_on ActiveJob::DeserializationError

  def perform(customer, message)
    Pushes::Sender.call(customer, message)
  end
end
