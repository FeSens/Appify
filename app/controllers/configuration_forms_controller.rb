class ConfigurationFormsController < ApplicationController
  def update
    ::Configuration.find(params[:id]).update(configuration_params)
    redirect_to home_index_path
  end

  private

  def configuration_params
    params.require(:configuration).permit(:enable_timer, :timer, :modal_text)
  end
end
