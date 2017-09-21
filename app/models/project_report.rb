class ProjectReport < ActiveRecord::Base

  belongs_to :company
  belongs_to :user

  validates :company_id,    presence: true
  validates :user_id,       presence: true
  validates :tracking_time, presence: true

  class << self

    def today
      where("created_at > '#{Date.today}'")
    end

    def week
      where("created_at > '#{Date.today.beginning_of_week}' and created_at < '#{Date.today.end_of_week}'")
    end

    def month
      where("created_at > '#{Date.today.beginning_of_month}' and created_at < '#{Date.today.end_of_month}'")
    end

  end

end
