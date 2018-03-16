class BillsController < ApplicationController
  skip_before_action :authenticate_user!, only: :new
  after_action :verify_authorized, except: :new
  def show
    @bill = Bill.find(params[:id])
    authorize @bill
  end

  def new
    # session[:table_number] = params[:table]
    @table = Table.find(params[:table])
    redirect_to table_path(@table)
  end
end
