ActiveAdmin.register Rate do
  permit_params :company_id, :amount

  filter :company_id, as: :select, collection: Company.all.map{ |company| ["#{company.name}", company.id]}
  filter :amount

  index do
    selectable_column
    id_column
    column :company_id
    column :amount
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :company_id
      row :amount
    end
  end

  form do |f|
    f.inputs "Rate Details" do
      f.input :company_id, as: :select, collection: Company.all.map{ |company| ["#{company.name}", company.id]}
      f.input :amount
    end
    f.actions
  end

end
