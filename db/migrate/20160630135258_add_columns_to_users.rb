class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :online, :boolean, default: false
    add_column :users, :away, :boolean, default: false
    add_column :users, :admin, :boolean, default: false
    add_column :users, :date_of_birth, :date, null: false
    add_column :users, :place_of_birth, :string, null: false
    add_column :users, :live_in_city, :string, null: false
  end
end
