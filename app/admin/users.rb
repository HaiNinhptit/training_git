ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
permit_params :email, :password, :password_confirmation, :name, :avatar

index do
  selectable_column
  id_column
  column :email
  column :name
  column :avatar
  column :current_sign_in_at
  column :sign_in_count
  column :created_at
  actions do |id|
    (link_to "List_products", admin_list_products_of_user_path(id)) + " " +
    (link_to "Get salesman" , admin_salesman_path(id))
  end
end


form do |f|
  f.inputs do
    f.input :email
    f.input :name
    f.input :avatar
    f.input :password
    f.input :password_confirmation
  end
  f.actions
end

end
