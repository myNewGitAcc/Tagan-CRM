class Post < ActiveRecord::Base
  belongs_to :user
  class << self
    def today
      where("created_at > '#{Date.today}'")
    end
  end
end
