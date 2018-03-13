class Table < ApplicationRecord
  belongs_to :restaurant
  has_many :bills
  has_many :orders, through: :bills




  def active_bill
   self.bills.where.(status: "unpaid")
  end

  def active_bill?
    active_bill.size == 1
  end

end
