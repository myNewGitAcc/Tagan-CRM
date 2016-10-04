class WorkingTime < ActiveRecord::Base
  belongs_to :user

  acts_as_api

  api_accessible :basic do |t|
    t.add :id
    t.add :user_id
    t.add :status_change_date
    t.add :labor_hours
    t.add :created_at
  end

end