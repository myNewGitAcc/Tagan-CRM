class RemoveTimestampsFromMailServerEmails < ActiveRecord::Migration
  def change
    remove_column :mail_server_emails, :created_at, :string
    remove_column :mail_server_emails, :updated_at, :string
  end
end
