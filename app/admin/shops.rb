ActiveAdmin.register Shop do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :push_limit, :name, :theme_verified, :locale, :plan_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:shopify_domain, :shopify_token, :domain, :push_limit, :plan_name, :name, :theme_verified, :last_auth, :last_activity, :metadata, :locale, :plan_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
