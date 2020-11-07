module Pushes
  class Sender
    attr_reader :broker

    cattr_accessor :default_adapter do
      "Pushes::Brokers::#{Rails.application.config.pushes_broker.to_s.classify}".constantize.new
    end

    def initialize(broker: nil)
      @broker = broker.presence || default_adapter
    end

    def deliver(customer, message, **args)
      broker.deliver(customer, message, **args)
    end

    def deliver_batch(customers, messages, **args)
      broker.deliver_batch(customers, messages, **args)
    end
  end
end
