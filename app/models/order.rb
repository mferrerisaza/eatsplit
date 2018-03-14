class Order < ApplicationRecord
  belongs_to :dish
  belongs_to :bill, optional: true
  belongs_to :user, optional: true
  monetize :amount_cents
end
