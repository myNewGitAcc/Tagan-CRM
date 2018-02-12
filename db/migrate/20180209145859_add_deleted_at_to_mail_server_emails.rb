class AddDeletedAtToMailServerEmails < ActiveRecord::Migration
  def change
    add_column :mail_server_emails, :deleted_at, :datetime
  end
end
