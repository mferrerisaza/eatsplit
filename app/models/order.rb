class Order < ApplicationRecord
  belongs_to :dish
  belongs_to :bill, optional: true
  belongs_to :user, optional: true
  belongs_to :picking_user, optional: true, class_name: "User"
  monetize :amount_cents

  def user_profile
    user.profile
  end

  def picking_user_profile
    picking_user&.profile
  end
end
