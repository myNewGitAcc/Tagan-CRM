class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string  :first_name
      t.string  :last_name
      t.string  :middle_name
      t.string  :email
      t.bigint  :phone
      t.text    :notes
      t.string  :attachment

      t.timestamps null: false
    end
  end
end
