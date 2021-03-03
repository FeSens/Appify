module Admin
  class OptinsController < AuthenticatedController
    before_action :load_optin, only: %i[update index]
    attr_accessor :optin

    def index; end

    def update
      optin.update(optin_params)
      flash[:success] = I18n.t("activerecord.successful.messages.updated", model: optin.class.model_name.human)
      redirect_to admin_settings_path(tab: optin.kind, anchor: "Optin")
    end

    private

    def optin_params
      params.require(:optin).permit(:title, :body, :accept_button, :decline_button,
                                    :background_color, :text_color, :timer, :enabled)
    end

    def load_optin
      return @optin = current_shop.optins.find(params[:id]) if params[:id].present?

      @optin = current_shop.optins.find_by(kind: params[:tab] || "push")
    end
  end
end
