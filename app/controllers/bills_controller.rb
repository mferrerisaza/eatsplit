class BillsController < ApplicationController
  skip_before_action :authenticate_user!, only: :create
  after_action :verify_authorized, except: :create

  def show
    flash[:just_ordered]= false
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

  def update
    @bill = Bill.find(params[:id])
    authorize @bill
    @bill.update(bill_params)
    @amount = @bill.check_orders
    render json: {success: true}
  end

  # def new
  #   # session[:table_number] = params[:table]
  #   @table = Table.find(params[:table])
  #   redirect_to table_path(@table)
  # end

  def create
    @table = Table.find(params[:table])
    redirect_to table_path(@table)
  end

  private

  def bill_params
    params.require(:bill).permit(order: [:id, :dish_id, :bill_id, :quantity, :status, :amount], orders_attributes: [:id, :dish_id, :bill_id, :quantity, :status, :amount])
  end
end
