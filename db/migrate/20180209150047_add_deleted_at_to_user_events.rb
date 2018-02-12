class AddDeletedAtToUserEvents < ActiveRecord::Migration
  def change
    add_column :user_events, :deleted_at, :datetime
  end
end
