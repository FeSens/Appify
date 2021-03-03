module Admin
  class MarketingValuesController < AuthenticatedController
    before_action :load_marketing_value, only: %i[edit update]
    attr_accessor :marketing_value

    def update
      marketing_value.update(marketing_value_params)
      flash[:success] = I18n.t("activerecord.successful.messages.updated", model: marketing_value.class.model_name.human)
      redirect_to admin_settings_path(anchor: "Marketing")
    end

    private

    def marketing_value_params
      params.require(:marketing_value).permit(:cpc, :cps, :cpd)
    end

    def load_marketing_value
      @marketing_value = current_shop.marketing_value
    end
  end
end