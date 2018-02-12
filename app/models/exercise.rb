class Exercise < ActiveRecord::Base
  belongs_to :user
  belongs_to :exercise_list
  acts_as_paranoid
end