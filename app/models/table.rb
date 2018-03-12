class Table < ApplicationRecord
  belongs_to :restaurant
  has_many :bills
  has_many :orders, through: :bills
end
