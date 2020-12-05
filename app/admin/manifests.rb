ActiveAdmin.register Manifest do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :short_name, :theme_color, :background_color, :display, :orientation, :start_url, :lang, :description
  #
  # or
  #
  # permit_params do
  #   permitted = [:shop_id, :name, :short_name, :theme_color, :background_color, :display, :orientation, :start_url, :lang, :description]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
