class MailServerEmails < ActiveRecord::Base
  belongs_to :user

  after_create  :add_user

  private

  def add_user
    self.update_attributes(user_id: User.find_by_email(self.address_to).id)
  end
end