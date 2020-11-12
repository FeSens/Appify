# frozen_string_literal: true

module WebhookContracts
  class Create < ApplicationContract
    params do
      required(:plataform).filled(:string)
      required(:identifier).filled(:string)
      required(:topic).filled(:string)
    end
  end
end
