class AddQuantityOfFreeToInventories < ActiveRecord::Migration
  def change
    add_column :inventories, :quantity_of_free, :integer, default: 0
  end
end
