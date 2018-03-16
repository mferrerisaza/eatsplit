class BillsController < ApplicationController
  skip_before_action :authenticate_user!, only: :new
  after_action :verify_authorized, except: :new
  def show
    @bill = Bill.find(params[:id])
    authorize @bill
  end

  def update

    @bill = Bill.find(params[:id])
    authorize @bill
    @bill.update(bill_params)
  end

  def new
    # session[:table_number] = params[:table]
    @table = Table.find(params[:table])
    redirect_to table_path(@table)
  end

  private

  def bill_params
    params.require(:bill).permit(order: [:id, :dish_id, :bill_id, :quantity, :status, :amount], orders_attributes: [:id, :dish_id, :bill_id, :quantity, :status, :amount])
  end
end
