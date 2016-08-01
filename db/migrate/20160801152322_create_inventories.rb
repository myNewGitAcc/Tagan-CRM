class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.integer :user_id
      t.integer :inventory_id
      t.string  :title
      t.date    :receipt_date
      t.integer :qtty_in_stock
      t.integer :qtty_of_employees

      t.timestamps null: false
    end
  end
end
