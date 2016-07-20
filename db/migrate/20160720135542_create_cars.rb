class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.integer :users_id
      t.text    :name
      t.boolean :is_stock
      t.integer :max_speed
      t.integer :price

      t.timestamps null: false
    end
  end
end
