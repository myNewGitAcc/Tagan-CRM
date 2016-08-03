class Inventory < ActiveRecord::Base
  belongs_to :type
  mount_uploader :avatar, AvatarUploader
end
