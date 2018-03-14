class TablesController < ApplicationController

  def show
    @table = Table.find(params[:id])
    authorize @table
    if @table.active_bill?
      @bill = @table.active_bill
    else
      @bill = Bill.create(table: @table)
    end
  end

end
