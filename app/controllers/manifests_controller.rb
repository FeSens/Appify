class ManifestsController < AuthenticatedController
  def update
    Manifest.find(params[:id]).update(manifest_params)
    redirect_to home_index_path
  end

  private

  def manifest_params
    params.require(:manifest).permit(:name, :short_name, :theme_color, :background_color, :display, :orientation)
  end
end
