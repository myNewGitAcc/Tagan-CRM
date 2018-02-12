class AddDeletedAtToUserScores < ActiveRecord::Migration
  def change
    add_column :user_scores, :deleted_at, :datetime
  end
end
