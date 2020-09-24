class PushSenderJob < ApplicationJob
  queue_as :critical
  discard_on ActiveJob::DeserializationError

  def perform(customer, message)
    Pushes::Sender.call(customer, message)
  end
end
