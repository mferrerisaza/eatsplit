class BillsController < ApplicationController
  def show
    @bill = Bill.find(params[:id])
    authorize @bill
  end

  def create
  end
end
