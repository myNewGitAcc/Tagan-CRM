class Article < ActiveRecord::Base

  acts_as_api

  belongs_to :user

   api_accessible :basic do |t|
     t.add :id
     t.add :user_id
     t.add :subject
     t.add :body
     t.add :created_at

   end

end
