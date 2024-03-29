class PushSenderJob < ApplicationJob
  queue_as :critical
  discard_on ActiveJob::DeserializationError

  def perform(customer, message)
    Pushes::Sender.new.deliver(customer, message)
  end
end
