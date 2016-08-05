class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.string :inventory_name
      t.integer :quantity_in_stock

      t.timestamps null: false
    end
  end
end
