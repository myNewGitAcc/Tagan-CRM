class CreateExerciseLists < ActiveRecord::Migration
  def change
    create_table :exercise_lists do |t|
      t.string    :exercise
      t.timestamps null: false
    end
  end
end
