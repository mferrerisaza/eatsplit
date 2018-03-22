class BillsController < ApplicationController
  skip_before_action :authenticate_user!, only: :create
  after_action :verify_authorized, except: :create

  def show
    @bill = Bill.find(params[:id])
    @your_orders = @bill.orders.where(user: current_user).where.not(status: "paid")
    @other_orders = @bill.orders.where.not(user: current_user).where.not(status: "paid")
    @paid_orders = @bill.orders.where(status: "paid")
    @bill.orders.where.not(status: "paid").each do |order|
      if order.user == current_user
        order.status = "1"
        order.picking_user = current_user
      else
        order.status = "0"
        order.picking_user = nil
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
