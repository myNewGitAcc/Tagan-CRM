class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.belongs_to :user, index: true
      t.string :subject,  null: false
      t.string :body,     null: false

      t.timestamps null: false
    end
  end
end
