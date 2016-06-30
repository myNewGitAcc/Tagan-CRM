class ChangeColumnNameRoleId < ActiveRecord::Migration
  def change
    rename_column :users, :role_id, :role
  end
end
