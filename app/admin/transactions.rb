ActiveAdmin.register Transaction do
  permit_params :name, :type, :amount, :info_raw, :internal_account_id

  action_item :view, only: :index do
    debit = Debit.active_account
    debit_amount = 0
    debit.each do |d|
      debit_amount += d.amount
    end

    credit = Credit.active_account
    credit_amount = 0
    credit.each do |c|
      credit_amount += c.amount
    end

    amount = credit_amount - debit_amount
    link_to "#{amount.round(2)} $"
  end

  filter :employee_name_eq,
         label: 'Employee',
         as: :select,
         collection: -> { Transaction.all.pluck(:info).flatten.map{|el| el['employee_name'] }.uniq }
  filter :invoice_info_eq,
         label: 'Invoice ID',
         as: :select,
         collection: -> { Transaction.all.pluck(:info).flatten.map{|el| el['invoice_id'] }.uniq }
  filter :type, as: :select, collection: ['Debit','Credit']
  filter :created_at, as: :date_range
  filter :internal_account_id, as: :select

  index do
    selectable_column
    id_column
    column :name
    column :type
    column :info
    column :amount
    column :created_at
    column :internal_account_id
    actions
  end

  show do
    attributes_table do
      row :name
      row :type
      row :info do
        transaction = Transaction.find_by_id(params[:id])
        if transaction.info['invoice_id'].present?
          invoice = Invoice.find_by_id(transaction.info['invoice_id'])
          link_to 'Invoice', admin_invoice_path(invoice)
        else
          transaction.info
        end
      end
      row :amount
      row :created_at
      row :internal_account_id
    end
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :name
      f.input :type, as: :select, collection: ['Debit','Credit']
      f.input :info_raw, as: :text, input_html: { class: 'jsoneditor-target' }
      f.input :amount
      f.input :internal_account_id, as: :select, collection: InternalAccount.all.map{ |account| ["#{account.name}", account.id]}
    end
    f.actions
  end

end
