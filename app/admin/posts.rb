ActiveAdmin.register Post do
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
menu parent: "Button"


  permit_params :title, :body, :user_id

  # filter :title
  # filter :user_id, as: :check_boxes

  config.filters = false

  sidebar :info do
    "Общее число постов: #{Post.count}"
  end

  batch_action :destroy, confirm: 'Are you sure?'

  breadcrumb do
    ['admin', 'dashboard', 'button']
  end
  
  scope :today do |i|
    i.today
  end
end
