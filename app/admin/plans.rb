ActiveAdmin.register Plan do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :price, :trial_days, :capped_amount, :terms, :push_limit
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :price, :trial_days, :capped_amount, :terms, :push_limit]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
