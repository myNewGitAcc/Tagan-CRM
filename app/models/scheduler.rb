class Scheduler < ActiveRecord::Base
  include ActiveAdmin::Callbacks
  before_save :create_background_job

  serialize :task, Hash

  has_many :jobs, as: :owner, class_name: "::Delayed::Job", dependent: :destroy

  attr_accessor :task_raw, :name

  def task_raw
    self.task unless self.task.nil?
  end

  def task_raw=(values)
    self.task = {}
    self.task=JSON.parse values.gsub('=>',':')
    jobs_identificate
  end

  def jobs_identificate
    case self.frequency
      when 'every 20 seconds'
        self.task['per_run_count'] = '20'
      when 'every minute'
        self.task['per_run_count'] = '60'
      when 'every 3 minutes'
        self.task['per_run_count'] = '180'
      else
        flash[:notice] = 'Please, select a frequency'
        redirect_to :back
    end
  end


  def time
    self['time'] ||= Time.now.utc
  end

  def frequency
    self['frequency'] ||= 'every 20 seconds'
  end

  def parse_timeout
    task['parse_timeout'].to_f
  end

  def per_run_count
    task['per_run_count'].to_i
  end

  def next_run
    I18n.localize(jobs.last.run_at, format: '%d/%m/%Y %I:%M %P') if jobs.last
  end

  def type_formatted
    type.to_s.demodulize.titleize.humanize
  end

  def time_formatted
    I18n.localize(time, format: '%d/%m/%Y %I:%M %P')
  end

  protected

  def run_at_changed?
    time_changed? || day_changed? || frequency_changed?
  end

  def run_at
    @run_at ||= time
  end

  def create_background_job
  end

end