class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer   :company_id
      t.string    :name
      t.string    :type
      t.json      :invoice_info
      t.datetime  :deleted_at

      t.timestamps null: false
    end
  end
end
