ActiveAdmin.register Invoice do
  permit_params :csv_file

  actions :all, :except => [:destroy, :edit]

  filter :team
  filter :freelancer
  filter :amount

  index do
    id_column
    column :date
    column :refference_id
    column :freelancer
    column :team
    column :amount
    column :created_at

    actions
  end

  form do |f|
    f.inputs "Invoice" do
      f.input :csv_file, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :date
      row :refference_id
      row :type_of_calculation
      row :description
      row :agency
      row :freelancer
      row :team
      row :account_name
      row :amount
      row :amount_in_local
      row :currency
    end
  end

  controller do

    def create
      if permitted_params[:invoice].present?
        csv_file = permitted_params[:invoice][:csv_file].read
        csv = CSV.parse(csv_file, :headers => true)
        csv.each do |row|
          invoice = Invoice.new(
                                date: row['Date'],
                                refference_id: row['Ref ID'],
                                type_of_calculation: row['Type'],
                                description: row['Description'],
                                agency: row['Agency'],
                                freelancer: row['Freelancer'],
                                team: row['Team'],
                                account_name: row['Account Name'],
                                amount: row['Amount'],
                                amount_in_local: row['Amount in local currency'],
                                currency: row['Currency']
                                )

          invoice.save
        end
      end
      redirect_to admin_invoices_path
    end

    def update
      @invoice = Invoice.find(params[:id])
      if @invoice.update(invoice_params)
        redirect_to admin_invoice_path(@invoice)
      else
        render action: 'edit'
      end
    end

    private

    def invoice_params
      params.require(:invoice).permit(:date, :refference_id, :type_of_calculation, :description, :agency, :freelancer, :team, :account_name, :amount,
                                   :amount_in_local, :currency)
    end

  end
end