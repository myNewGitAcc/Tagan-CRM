class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :user_id
      t.string :subject
      t.string :body

      t.timestamps null: false
    end
  end
end
