class AddColumnStatusToUsers < ActiveRecord::Migration
  def up
    remove_columns :users, :online, :away
  end

  def downn
    add_column :users, :status, :integer
  end
end
