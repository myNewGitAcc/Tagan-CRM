ActiveAdmin.register Company do
  permit_params :name

  filter :name
  filter :created_at

  index do
    selectable_column
    id_column
    column :name
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :created_at
    end
  end

  form do |f|
    f.inputs "Company Details" do
      f.input :name
    end
    f.actions
  end

end
