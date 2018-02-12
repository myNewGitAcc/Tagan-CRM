class UserScore < ActiveRecord::Base

  self.inheritance_column = nil

  enum type: [:debit, :credit]

  belongs_to :user
  acts_as_paranoid

end
