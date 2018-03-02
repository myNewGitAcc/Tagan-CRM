class UserScore < ActiveRecord::Base

  self.inheritance_column = nil

  enum type: [:debit, :credit]

  acts_as_paranoid

  belongs_to :user

end
