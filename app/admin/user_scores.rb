ActiveAdmin.register UserScore do
  permit_params :user_id, :value, :type, :note

  filter :user_id, as: :select, collection: User.all.map{ |user| ["#{user.full_name}", user.id]}
  filter :value

  index do
    selectable_column
    id_column
    column :user_id
    column :value
    column :type
    actions
  end

  show do
    attributes_table do
      row :user_id
      row :value
      row :type
      row :note
      column :created_at
    end
  end

  form do |f|
    f.inputs "Score" do
      f.input :user_id, as: :select, collection: User.all.map{ |user| ["#{user.full_name}", user.id]}
      f.input :value
      f.input :type
      f.input :note
    end
    f.actions
  end

end
