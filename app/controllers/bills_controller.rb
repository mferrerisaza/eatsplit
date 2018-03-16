class BillsController < ApplicationController
  def show
    @bill = Bill.find(params[:id])
    authorize @bill
  end
end
