#require 'aws-sdk-sqs'  # v2: require 'aws-sdk'

module Pushes
  module Brokers
    class Base
      def deliver(customer, message, **args)
        raise NotImplementedError
      end

      def deliver_batch(customers, messages, **args)
        raise NotImplementedError
      end
    end
  end
end
