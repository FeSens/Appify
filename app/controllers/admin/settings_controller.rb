module Admin
  class SettingsController < AuthenticatedController
    def index
      @manifest = current_shop.manifest
      @optin = current_shop.optins.find_by(kind: params[:tab] || "push")
      @marketing_value = current_shop.marketing_value
    end
  end
end
