class BillsController < ApplicationController
  skip_before_action :authenticate_user!, only: :create
  after_action :verify_authorized, except: :create

  def show
    @bill = Bill.find(params[:id])
    @bill.orders.where.not(status: "paid").each do |order|
      if order.user == current_user
        order.status = "1"
      else
        order.status = "0"
      end
      order.save!
    end
    authorize @bill
  end

  def create
    @table = Table.find(params[:table])
    redirect_to table_path(@table)
  end

end
