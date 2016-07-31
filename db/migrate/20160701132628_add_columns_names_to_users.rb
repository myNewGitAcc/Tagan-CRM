class AddColumnsNamesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :middle_name, :string
    add_column :users, :place_id, :string
    add_column :users, :location_id, :string
  end
end
