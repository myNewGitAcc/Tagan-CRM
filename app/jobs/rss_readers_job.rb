class RssReadersJob

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
    rss_reader = RssReader.all
    rss_reader.each do |rss|
      results = {}
      results[:response] = []
      email = rss.email.split(',')
      feed = Feedjira::Feed.fetch_and_parse(rss.url)
      title = feed.title
      rss_entries = rss.time_last_news.nil? ? feed.entries : feed.entries.select{|e| e.published > rss.time_last_news}
      rss_entries.sort_by{|rss_entry| rss_entry.published}.each_with_index do |entries, i|
        info = {}
        info[:title] =  entries.title
        info[:url]   =  entries.url
        info[:summary] = entries.summary
        results[:response] << info
        rss.update(time_last_news: entries.published) if rss_entries.size-1 == i
      end
      unless results[:response].blank?
        email.each { |email|
          RssReaderMailer.rss_reader_changes(email.strip, results, title).deliver_now
        }
      end
    end

  end

  protected

  def task_id
    @task_id.to_i
  end

  def parse_timeout
    @parse_timeout ||= task.parse_timeout
  end

  def task
    @task ||= Scheduler::RssReadersImport.find(task_id)
  end

  def add_next_job job
    last_run = Time.now.utc
    run_at = last_run + task.per_run_count.seconds
    Delayed::Job.create handler: RssReadersJob.new.to_yaml, run_at: run_at, scheduled_at: run_at, last_run: last_run,
                        owner_type: job.owner_type, owner_id: job.owner_id.to_i, priority: 3
  end

end