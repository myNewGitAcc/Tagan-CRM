class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.integer   :company_id
      t.integer   :amount, default: 5
      t.datetime  :deleted_at

      t.timestamps null: false
    end
  end
end
