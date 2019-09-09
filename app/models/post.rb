class Post < ActiveRecord::Base

  class << self
    def today
      where("created_at > '#{Date.today}'")
    end
  end
end
