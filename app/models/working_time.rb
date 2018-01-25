class WorkingTime < ActiveRecord::Base
  belongs_to :user

  scope :for_today, ->{ joins('INNER JOIN users ON (working_times.user_id = users.id AND users.status = 1)')
                          .where(created_at: Time.now.beginning_of_day..Time.now.end_of_day)}

  acts_as_api

  api_accessible :basic do |t|
    t.add :id
    t.add :user_id
    t.add :status_change_date
    t.add :labor_hours
    t.add :created_at
    t.add :updated_at
  end

end