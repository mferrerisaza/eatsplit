class BillsController < ApplicationController
  def show
    @bill = Bill.find(params[:id])
    authorize @bill
  end

  def update

    @bill = Bill.find(params[:id])
    authorize @bill
    @bill.update(bill_params)
  end

  private

  def bill_params
    params.require(:bill).permit(order: [:id, :dish_id, :bill_id, :quantity, :status, :amount], orders_attributes: [:id, :dish_id, :bill_id, :quantity, :status, :amount])
  end
end
