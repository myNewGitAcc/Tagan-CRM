class Event < ActiveRecord::Base

  just_define_datetime_picker :start_time, add_to_attr_accessor: true
  just_define_datetime_picker :end_time, add_to_attr_accessor: true

  has_and_belongs_to_many :candidates, through: :candidates_events

  def start_time
    self['start_time'] ||= Time.now
  end

  def end_time
    self['end_time'] ||= Time.now
  end

end