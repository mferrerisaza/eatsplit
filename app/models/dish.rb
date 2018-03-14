class Dish < ApplicationRecord
  CATEGORY = ["Starter", "Main", "Dessert"]
  belongs_to :restaurant
  has_many :orders
  mount_uploader :photo, PhotoUploader
  monetize :price_cents

  validates :category, inclusion: { in: CATEGORY}
end
