class SendDumpJob

  def before(job)
    @task_id = job.owner_id
  end

  def success(job)
    `rm #{Rails.root}/public/dump`
    add_next_job(job)
  end

  def max_attempts
    return 1
  end

  def perform
    `pg_dump -F c #{ENV['DATABASE_URL']} -f public/dump`
     SupportMailer.send_dump("#{Time.now.in_time_zone('Moscow').strftime("%Y%m%d%H%M%S")}_dump", Time.now.in_time_zone('Moscow').strftime("%d-%m-%Y")).deliver
  end

  protected

  def task_id
    @task_id.to_i
  end

  def task
    @task ||= Scheduler::SendDump.find(task_id)
  end

  def add_next_job(job)
    last_run = Time.now.utc
    next_run = last_run + task.per_run_count
    Delayed::Job.create handler: SendDumpJob.new.to_yaml,  run_at: next_run, scheduled_at: next_run, last_run: last_run,
                        owner_type: job.owner_type, owner_id: job.owner_id.to_i, priority: 3
  end

end