class AddColumnsNamesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string,  null: false
    add_column :users, :last_name, :string,   null: false
    add_column :users, :middle_name, :string, null: false
    add_column :users, :place_id, :string,    null: false
    add_column :users, :live_id, :string,     null: false
  end
end
