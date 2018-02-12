class AddDeletedAtToExercises < ActiveRecord::Migration
  def change
    add_column :exercises, :deleted_at, :datetime
  end
end
