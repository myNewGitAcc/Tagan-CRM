class UserEvent < ActiveRecord::Base

  just_define_datetime_picker :start, add_to_attr_accessor: true
  just_define_datetime_picker :end, add_to_attr_accessor: true

  def start
    self['start'] ||= Time.now
  end

  def end
    self['end'] ||= Time.now
  end

end