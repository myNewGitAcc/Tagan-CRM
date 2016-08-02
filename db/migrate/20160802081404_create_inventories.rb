class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.integer :user_id
      t.integer :inventory_id
      t.string :title
      t.date :date_of_receipt
      t.integer :guantity_in_stock
      t.integer :quantity_of_employees

      t.timestamps null: false
    end
  end
end
