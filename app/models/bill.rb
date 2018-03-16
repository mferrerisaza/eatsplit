class Bill < ApplicationRecord
  belongs_to :table
  has_many :orders
  has_many :dishes, through: :orders
  has_many :users, through: :orders
  monetize :balance_cents
  validate :check_if_unique_status, on: :create


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
      sum += order.amount
    end
    self.balance = sum
    self.save
  end



end
