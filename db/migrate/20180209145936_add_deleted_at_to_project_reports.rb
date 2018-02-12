class AddDeletedAtToProjectReports < ActiveRecord::Migration
  def change
    add_column :project_reports, :deleted_at, :datetime
  end
end
