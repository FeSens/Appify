# frozen_string_literal: true

module PushContracts
  class Create < ApplicationContract
    params do
      required(:url).filled(:string)
      required(:status).filled(:string)
      required(:message).filled(:string)
      required(:subscriber_id).filled(:string)
    end
  end
end
