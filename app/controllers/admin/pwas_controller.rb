module Admin
  class PwasController < AuthenticatedController
    def edit
      @manifest = shop.manifest
    end

    def update
      shop.manifest.update(manifest_params)
      flash[:success] = "Updated with success"
      redirect_to edit_admin_pwa_path
    end

    private

    def manifest_params
      params.require(:manifest).permit(:name, :short_name, :icon, :description,
                                       :theme_color, :background_color)
    end
  end
end