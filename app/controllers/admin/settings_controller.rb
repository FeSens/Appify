module Admin
  class SettingsController < AuthenticatedController
    def index
      @manifest = current_shop.manifest
      @optin = current_shop.optins.find_by(kind: params[:tab] || "push")
    end
  end
end
