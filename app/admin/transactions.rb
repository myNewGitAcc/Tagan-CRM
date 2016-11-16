ActiveAdmin.register Transaction do
  permit_params :name, :type, :amount, :info_raw

  action_item :view, only: :index do
    debit = Transaction::Debit.write_off
    debit_amount = 0
    debit.each do |d|
      debit_amount += d.amount
    end

    credit = Transaction::Credit.all
    credit_amount = 0
    credit.each do |c|
      credit_amount += c.amount
    end

    amount = credit_amount - debit_amount

    link_to "#{amount.round(2)} $"
  end

  index do
    selectable_column
    id_column
    column :name
    column :type
    column :info
    column :amount
    column :created_at
    actions
  end

  filter :info, # note _eq here
          as: :select,
          collection: -> { Transaction.all.pluck(:info).flatten.map {|el| el }.uniq }
  filter :type
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :name
      f.input :type, as: :select, collection: ['Debit','Credit']
      f.input :info_raw, as: :text
      f.input :amount
    end
    f.actions
  end

end
