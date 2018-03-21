class Order < ApplicationRecord
  belongs_to :dish
  belongs_to :bill, optional: true
  belongs_to :user, optional: true
  belongs_to :picking_user, optional: true, class_name: "User"
  monetize :amount_cents
end
