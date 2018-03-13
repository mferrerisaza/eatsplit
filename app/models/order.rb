class Order < ApplicationRecord
  belongs_to :dish
  belongs_to :bill
  belongs_to :user
  monetize :amount_cents
end
