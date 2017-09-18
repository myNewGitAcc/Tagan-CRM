class CreateProjectControls < ActiveRecord::Migration
  def change
    create_table :project_controls do |t|
      t.string      :project
      t.references  :user
      t.time        :work_time
      t.integer     :payment
      t.timestamps null: false
    end
  end
end
