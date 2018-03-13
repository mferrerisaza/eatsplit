class Bill < ApplicationRecord
  belongs_to :table
  has_many :orders
  has_many :dishes, through: :orders
  has_many :users, through: :orders
  monetize :balance_cents
end
