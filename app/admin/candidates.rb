ActiveAdmin.register Candidate do
  permit_params :first_name, :last_name, :middle_name, :email, :phone, :notes, :attachment
  config.batch_actions = false

  index do
    selectable_column
    id_column
    column :full_name do |user|
      user.full_name
    end
    column :email
    column :phone
    column :notes
    actions
  end

  filter :email

  form do |f|
    f.inputs "Admin Details" do
      f.input :first_name
      f.input :last_name
      f.input :middle_name
      f.input :email
      f.input :phone
      f.input :notes
      f.input :attachment
    end
    f.actions
  end

end
