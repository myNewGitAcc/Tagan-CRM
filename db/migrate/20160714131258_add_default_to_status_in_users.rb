class AddDefaultToStatusInUsers < ActiveRecord::Migration
  def up
    change_column :users, :status, :integer, default: 0
  end

  def down
    change_column :users, :status, :integer, default: nil
  end
end
