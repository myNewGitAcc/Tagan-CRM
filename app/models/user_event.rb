class UserEvent < ActiveRecord::Base

  validate :check_valid_start_and_end
  acts_as_paranoid

  before_save :set_minutes

  def start
    self['start'] ||= Time.now
  end

  def end
    self['end'] ||= Time.now
  end

  private

  def set_minutes
    self['start'] = self['start'].at_beginning_of_hour()
    self['end']   = self['end'].at_beginning_of_hour()
  end

  def check_valid_start_and_end
    hour = (Time.parse("#{self['end']}") - Time.parse("#{self['start']}")).to_i/60/60
    if hour < 1
      self.errors.add :end, 'The minimum event interval should be 1 hour'
    end
  end

end