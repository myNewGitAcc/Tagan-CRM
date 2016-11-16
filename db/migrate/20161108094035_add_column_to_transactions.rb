class AddColumnToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :amount, :real
  end
end
