module Admin
  class FlowChartsController < AuthenticatedController
    attr_accessor :flow_chart
    before_action :load_flow_chart, only: %i[edit update destroy]

    def index; end

    def edit; end

    def new 
      @templates = current_shop.campaigns
      @flow_chart = current_shop.flow_charts.new 
    end

    def create 
      @flow_chart  = current_shop.flow_charts.create(flow_chart_params)
      
      redirect_to admin_flow_chart_edit_path(@flow_chart)
    end

    def update; end

    def destroy; end

    private

    def flow_chart_params
      params.require(:flow_chart).permit(:chart_metadata)
    end

    def load_flow_chart
      @flow_chart = current_shop.flow_charts.find(params[:id])
    end
  end
end
