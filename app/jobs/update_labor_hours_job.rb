class UpdateLaborHoursJob

  def success(job)
    add_next_job
  end

  def max_attempts
    return 1
  end

  def perform
    WorkingTime.all.for_today.each do |labor_time|
      labor_time.labor_hours = 0 if labor_time.labor_hours.nil?
      labor_time.labor_hours += (1000*(Time.now.utc - labor_time.updated_at)).to_i
      labor_time.save
    end
  end

  protected

  def add_next_job
    last_run = Time.now.utc
    next_run = last_run > daily_start_time && last_run < daily_end_time ? last_run + 10.minute : daily_start_time + 1.day
    Delayed::Job.create handler: UpdateLaborHoursJob.new.to_yaml, run_at: next_run, scheduled_at: next_run, last_run: last_run, priority: 0
  end

  def daily_start_time
    Time.now.utc.change(hour: 5, min: 30)
  end

  def daily_end_time
    Time.now.utc.change(hour: 18, min: 0)
  end

end