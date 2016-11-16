ActiveAdmin.register Commission do
  permit_params :company_id, :percent

  filter :company_id, as: :select, collection: Company.all.map{ |company| ["#{company.name}", company.id]}
  filter :amount

  index do
    selectable_column
    id_column
    column :company_id
    column :percent
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :company_id
      row :percent
    end
  end

  form do |f|
    f.inputs "Company Details" do
      f.input :company_id, as: :select, collection: Company.all.map{ |company| ["#{company.name}", company.id]}
      f.input :percent
    end
    f.actions
  end

end
