class Restaurant < ApplicationRecord
  has_many :dishes
  has_many :tables
  mount_uploader :photo, PhotoUploader
  mount_uploader :logo, PhotoUploader
end
