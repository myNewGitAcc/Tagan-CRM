class CreateCommissions < ActiveRecord::Migration
  def change
    create_table :commissions do |t|
      t.integer   :company_id
      t.integer   :percent, default: 10
      t.datetime  :deleted_at

      t.timestamps null: false
    end
  end
end
