class Order < ApplicationRecord
  belongs_to :dish
  belongs_to :bill
  belongs_to :user
end
