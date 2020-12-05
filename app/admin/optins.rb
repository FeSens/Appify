ActiveAdmin.register Optin do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :body, :accept_button, :decline_button, :background_color, :text_color, :timer, :enabled
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :body, :accept_button, :decline_button, :background_color, :text_color, :timer, :enabled, :kind, :shop_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
