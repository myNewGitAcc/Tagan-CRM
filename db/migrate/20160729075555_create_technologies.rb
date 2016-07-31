class CreateTechnologies < ActiveRecord::Migration
  def change
    create_table :technologies do |t|
      t.string :title,    null: false
      t.string :comment,  null: false
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
