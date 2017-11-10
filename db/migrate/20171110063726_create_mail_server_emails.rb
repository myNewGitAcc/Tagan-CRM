class CreateMailServerEmails < ActiveRecord::Migration
  def change
    create_table :mail_server_emails do |t|
      t.belongs_to  :user
      t.text  :address_from
      t.text  :address_to
      t.text  :body
      t.timestamps null: false
    end
  end
end

