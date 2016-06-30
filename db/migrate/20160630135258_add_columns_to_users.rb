class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :online, :boolean, default: false
    add_column :users, :away, :boolean, default: false
  end
end
