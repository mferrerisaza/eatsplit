class OrdersController < ApplicationController
  def create
    dish = Dish.find(params[:dish_id])
    amount = dish.price
    @order = Order.create!(dish: dish, amount: dish.price)
    @old_amount = 0
    authorize @order
    session[:order_ids] = [] if session[:order_ids].blank?
    session[:order_ids] << @order.id
    respond_to do |format|
      format.html {}
      format.js
    end

  end

  def update
    @order = Order.find(params[:id])
    authorize @order
    @old_amount = @order.amount
    if params["update"] == "plus"
      @order.quantity += 1
      @order.amount = @order.quantity * @order.dish.price
    elsif params["update"] == "minus"
      @order.quantity -= 1
      @order.amount = @order.quantity * @order.dish.price
    end
    if @order.quantity == 0
      session[:order_ids].delete(@order.id)
      @order.destroy
    else
      @order.save
    end

    respond_to do |format|
      format.html {}
      format.js
    end
  end

  def checkout
    @orders = session[:order_ids].map do |order_id|
      Order.find(order_id)
    end
    @orders.each do |order|
      authorize order
    end
  end
end
