class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.integer :user_id
      t.integer :inventory_id
      t.string :employee
      t.date :date_of_receipt
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
