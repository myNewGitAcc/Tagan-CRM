class RenameColumnInTransactions < ActiveRecord::Migration
  def change
    rename_column :transactions, :invoice_info, :info
  end
end
