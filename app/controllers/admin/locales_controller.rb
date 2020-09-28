# frozen_string_literal: true
module Admin
  class LocalesController < AuthenticatedController
    def update
      current_shop.update(locale: params[:locale])
      redirect_to params[:redirect_to]
    end
  end
end
