class SendDumpJob

  def success(job)
    `rm #{Rails.root}/public/dump`
    add_next_job
  end

  def max_attempts
    return 1
  end

  def perform
    `pg_dump -F c #{ENV['DATABASE_URL']} -f public/dump`
     SupportMailer.send_dump("#{Time.now.in_time_zone('Moscow').strftime("%Y%m%d%H%M%S")}_dump", Time.now.in_time_zone('Moscow').strftime("%d-%m-%Y")).deliver
  end

  protected

  def add_next_job
    next_run = (Time.now.in_time_zone('Moscow').beginning_of_day) + 4.days
    Delayed::Job.create handler: SendDumpJob.new.to_yaml, run_at: next_run
  end

end