module Admin
  class PwasController < AuthenticatedController
    before_action :load_manifest, only: %i[update]
    attr_accessor :manifest

    def edit
      @manifest = current_shop.manifest
    end

    def update
      manifest.update(manifest_params)
      flash[:success] = "Updated with success"
      redirect_to edit_admin_pwa_path
    end

    private

    def manifest_params
      params.require(:manifest).permit(:name, :short_name, :icon, :description, :background_color)
        .merge(theme_color: params.dig(:manifest,:background_color),
               short_name:  params.dig(:manifest,:name))
    end

    def load_manifest
      @manifest = current_shop.manifest
    end
  end
end
