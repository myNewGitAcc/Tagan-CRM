class AddDeletedAtToWorkingTimes < ActiveRecord::Migration
  def change
    add_column :working_times, :deleted_at, :datetime
    add_index :working_times, :deleted_at
  end
end
