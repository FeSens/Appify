module Admin
  class FlowChartsController < AuthenticatedController
    attr_accessor :flow_chart, :templates
    before_action :load_flow_chart, only: %i[edit update destroy]
    before_action :load_templates, only: %i[edit new]

    def index; end

    def edit; end

    def new 
      @flow_chart = current_shop.flow_charts.new 
    end

    def create 
      @flow_chart  = current_shop.flow_charts.create(flow_chart_params)
      flash[:success] = "Automação criada com sucesso!"

      redirect_to edit_admin_flow_chart_path(@flow_chart)
    end

    def update
      flow_chart.update(flow_chart_params)
      flash[:success] = "Automação editada com sucesso!"

      redirect_to edit_admin_flow_chart_path(flow_chart)
    end

    def destroy; end

    private

    def flow_chart_params
      p = params.require(:flow_chart).permit(:chart_metadata)
      p[:chart_metadata] = JSON.parse(p[:chart_metadata])
      p
    end

    def load_flow_chart
      @flow_chart = current_shop.flow_charts.find(params[:id])
    end

    def load_templates
      @templates = current_shop.campaigns
    end
  end
end
