class CandidatesEvents < ActiveRecord::Migration
  def change
    create_table :candidates_events do |t|
      t.references :candidate
      t.references :event
      t.timestamps null: false
    end
  end
end
