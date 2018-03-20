class Bill < ApplicationRecord
  belongs_to :table
  has_many :orders
  has_many :dishes, through: :orders
  has_many :users, through: :orders
  monetize :balance_cents
  validate :check_if_unique_status, on: :create
  accepts_nested_attributes_for :orders


  def check_if_unique_status
    if self.table.active_bill?
      errors.messages[:bill] << "Just one active bill per table"
      return false
    else
      true
    end
  end

  def update_balance
    sum = 0
    self.orders.each do |order|
      if order.status != "paid"
        sum += order.amount
      end
    end
    self.balance = sum
    self.save
  end

  def check_orders
    amount=0
    self.orders.each do |order|
      if order.status == "1"
        amount += order.amount
      end
    end
    return amount
  end

end
