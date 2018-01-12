class Candidate < ActiveRecord::Base
  mount_uploader :attachment, AttachmentUploader

  has_and_belongs_to_many :events, through: :candidates_events

  def full_name
    "#{self.last_name} #{self.first_name} #{self.middle_name}"
  end
end
