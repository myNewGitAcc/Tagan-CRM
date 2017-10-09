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
      where("created_at > '#{Date.today.beginning_of_week}' and created_at < '#{Time.now.end_of_week}'")
    end

    def month
      where("created_at > '#{Date.today.beginning_of_month}' and created_at < '#{Time.now.end_of_month}'")
    end

    def get_companies
      where("created_at > '#{1.month.ago}'").pluck(:company_id).uniq
    end

    def get_time_current_time company_id
      time = self.week.where(company_id: company_id).sum(:tracking_time)
      return "00:00" if time.to_i == 0
      time.scan(/\d*.\d*/)[0]
    end

    def get_time company_id, start_date, end_date
      time = self.where("created_at > '#{Date.parse(start_date)}' and created_at < '#{Date.parse(end_date)}' and company_id = '#{company_id}'")
                 .sum(:tracking_time)

      return "00:00" if time.to_i == 0
      time.scan(/\d*.\d*/)[0]
    end


  end

end
