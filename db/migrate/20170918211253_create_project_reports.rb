class CreateProjectReports < ActiveRecord::Migration
  def change
    create_table :project_reports do |t|
      t.references  :company
      t.references  :user
      t.time        :tracking_time
      t.decimal     :earnings, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
