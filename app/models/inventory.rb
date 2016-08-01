class Inventory < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
end
