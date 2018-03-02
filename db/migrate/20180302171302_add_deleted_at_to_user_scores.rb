class AddDeletedAtToUserScores < ActiveRecord::Migration
  def change
    add_column :user_scores, :deleted_at, :datetime
    add_index :user_scores, :deleted_at
  end
end
