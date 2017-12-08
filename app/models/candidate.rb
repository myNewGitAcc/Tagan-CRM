class Candidate < ActiveRecord::Base
  mount_uploader :attachment, AttachmentUploader

  def full_name
    "#{self.last_name} #{self.first_name} #{self.middle_name}"
  end
end
