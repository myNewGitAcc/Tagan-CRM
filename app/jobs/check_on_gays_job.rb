class CheckOnGaysJob

  def before(job)
    @task_id = job.owner_id
  end

  def success(job)
    add_next_job job
  end

  def max_attempts
    return 1
  end

  def perform
    User.where.not(status: 0).each do |user|
      user.debit_score!(0.5, 'Не отметился об уходе (auto check on status)')
    end
  end

  protected

  def task_id
    @task_id.to_i
  end

  def task
    @task ||= Scheduler::CheckOnGaysJob.find(task_id)
  end

  def add_next_job job
    next_run = (DateTime.now.beginning_of_day) + 1.day
    Delayed::Job.create handler: CheckOnGaysJob.new.to_yaml, run_at: next_run, scheduled_at: next_run, last_run: Time.now.utc,
                        owner_type: job.owner_type, owner_id: job.owner_id.to_i, priority: 0
  end

end