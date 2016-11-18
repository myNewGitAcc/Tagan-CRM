ActiveAdmin.register InternalAccount do
  permit_params :account_type, :name, :description, :active

  filter :account_type, as: :select, collection: [ :card, :bank]
  filter :name
  filter :active

  index do
    selectable_column
    id_column
    column :account_type
    column :name
    column :active
    actions
  end

  show do
    attributes_table do
      row :account_type
      row :name
      row :description
      row :active
    end
  end

  form do |f|
    f.inputs "Internal Account Details" do
      f.input :account_type
      f.input :name
      f.input :description
      f.input :active
    end
    f.actions
  end

end
