class CreateUserScores < ActiveRecord::Migration
  def change
    create_table :user_scores do |t|
      t.references  :user
      t.decimal     :value, precision: 8, scale: 2
      t.text        :note
      t.integer     :type

      t.timestamps null: false
    end
  end
end
