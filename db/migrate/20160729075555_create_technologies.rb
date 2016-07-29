class CreateTechnologies < ActiveRecord::Migration
  def change
    create_table :technologies do |t|
      t.string :title,    null: false
      t.string :comment,  null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end
  end
end
