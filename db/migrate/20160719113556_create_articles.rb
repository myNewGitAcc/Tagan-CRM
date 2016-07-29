class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :user_id
      t.string :subject,  null: false
      t.string :body,     null: false

      t.timestamps null: false
    end
  end
end
