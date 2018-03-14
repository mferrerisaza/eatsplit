class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :dishes
  has_many :tables
  mount_uploader :photo, PhotoUploader
  mount_uploader :logo, PhotoUploader

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
