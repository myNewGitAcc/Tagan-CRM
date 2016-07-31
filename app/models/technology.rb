class Technology < ActiveRecord::Base

  belongs_to :user
  validate :invalid

  acts_as_api

  api_accessible :basic do |t|
    t.add :id
    t.add :title
    t.add :comment
    t.add :user_id
  end

  def invalid
    if self.title == ''
      errors.add(:title, "can't be blank")
    end
    if self.comment == ''
         errors.add(:comment, "can't be blank")
    end
  end

end
