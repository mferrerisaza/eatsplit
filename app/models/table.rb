class Table < ApplicationRecord
  belongs_to :restaurant
  has_many :bills
  has_many :orders, through: :bills




  def active_bill
    self.bills.where(status: "unpaid")[0]
  end

  def active_bill?
    self.bills.where(status: "unpaid").size == 1
  end

end
