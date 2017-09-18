ActiveAdmin.register ProjectControl do
  permit_params :user_id, :project, :work_time, :payment

  index do
    selectable_column
    id_column
    column :user
    column :project
    column :work_time
    column :payment
    actions
  end

  filter :updated_at, as: :date_range

  form do |f|
    f.inputs "User Details" do
      f.input :user
      f.input :project
      f.input :work_time
      f.input :payment
    end
    f.actions
  end

end
