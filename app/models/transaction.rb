class Transaction < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :company


  def info_raw
    self.info unless self.info.nil?
  end

  def info_raw=(values)
    write_attribute(:info, JSON.parse(values.gsub('=>',':')))
  end
end