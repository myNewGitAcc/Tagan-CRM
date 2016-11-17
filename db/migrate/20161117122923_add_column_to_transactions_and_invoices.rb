class AddColumnToTransactionsAndInvoices < ActiveRecord::Migration
  def change
    add_column :transactions, :internal_account_id, :integer, null: false
    add_column :invoices, :internal_account_id, :integer, null: false
  end
end
