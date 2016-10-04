class CreateWorkingTime < ActiveRecord::Migration
  def change
    create_table :working_times do |t|
      t.integer   :user_id
      t.datetime  :status_change_date
      t.integer   :labor_hours

      t.timestamps null: false
    end
  end
end
