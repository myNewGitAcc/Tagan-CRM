class CreateInternalAccounts < ActiveRecord::Migration
  def change
    create_table :internal_accounts do |t|
      t.integer   :account_type
      t.string    :name
      t.string    :description
      t.boolean   :active
      t.datetime  :deleted_at

      t.timestamps null: false
    end
  end
end
