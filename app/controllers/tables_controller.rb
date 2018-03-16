class TablesController < ApplicationController

  def show

    @table = Table.find(params[:id])
    authorize @table

    @dishes = policy_scope(@table.restaurant.dishes)
    @drinks = @dishes.select { |dish| dish.category == "Drink"}
    @starters = @dishes.select { |dish| dish.category == "Starter"}
    @mains = @dishes.select { |dish| dish.category == "Main"}
    @desserts = @dishes.select { |dish| dish.category == "Dessert"}

#move this to bill controller create
#al crear el bill:
    if @table.active_bill?
      @bill = @table.active_bill
  #redireccionar a tabledashboard
    else
      @bill = Bill.create(table: @table)
  #redireccionar al table dashboard
    end
  end

end
