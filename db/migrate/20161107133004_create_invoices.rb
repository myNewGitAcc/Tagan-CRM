class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer   :company_id
      t.date      :date
      t.integer   :refference_id
      t.string    :type_of_calculation
      t.string    :description
      t.string    :agency
      t.string    :freelancer
      t.string    :team
      t.string    :account_name
      t.integer   :amount
      t.integer   :amount_in_local
      t.string    :currency
      t.datetime  :deleted_at

      t.timestamps null: false
    end
  end
end
