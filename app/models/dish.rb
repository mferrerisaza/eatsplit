class Dish < ApplicationRecord
  belongs_to :restaurant
  has_many :orders
  mount_uploader :photo, PhotoUploader
end
