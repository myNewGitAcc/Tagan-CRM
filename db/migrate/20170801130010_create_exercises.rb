class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.references  :exercise_list
      t.references  :user
      t.string      :weight
      t.timestamps null: false
    end
  end
end
