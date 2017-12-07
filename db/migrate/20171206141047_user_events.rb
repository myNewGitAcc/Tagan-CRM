class UserEvents < ActiveRecord::Migration
  def change
    create_table :user_events do |t|
      t.references  :user
      t.string      :event
      t.datetime    :start
      t.datetime    :end

      t.timestamps null: false
    end
  end
end
