class TablesController < ApplicationController

  def index
   @restaurant = Restaurant.find(params[:restaurant_id])
   @tables = policy_scope(@restaurant.tables)

  end

  def show
    @table = Table.find(params[:id])
    authorize @table

    @dishes = policy_scope(@table.restaurant.dishes)
    @drinks = @dishes.select { |dish| dish.category == "Drink"}
    @starters = @dishes.select { |dish| dish.category == "Starter"}
    @mains = @dishes.select { |dish| dish.category == "Main"}
    @desserts = @dishes.select { |dish| dish.category == "Dessert"}

    # Set current user = to the orders store on the session
    session[:order_ids] = [] if session[:order_ids].blank?
    session[:order_ids].each do |id|
      order= Order.find(id)
      order.user = current_user
      order.save
    end

    # Create an instance variables of orders finding the orders by id
    @orders = session[:order_ids].map { |id| Order.find(id)}
    session[:order_ids] =[]
    flash[:notice]= "Orders successfully processed" unless @orders.size == 0
    if @table.active_bill?
      # if the table already has a bill, add orders to the bill
      @bill = @table.active_bill
      @bill.orders << @orders
      @bill.update_balance

    else
      # Else create a bill and add orders to the bill
      @bill = Bill.create(table: @table)
      @bill.orders << @orders
      @bill.update_balance
    end
  end

end
