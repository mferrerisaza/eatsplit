class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :create, :update, :checkout]

  def index
    @bill = Bill.find(params[:bill_id])
    render json: { orders: policy_scope(@bill.orders)}
  end

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
    elsif params["update"] == "toggle_check"
      if @order.status == "1"
        @order.update(status: "0", picking_user: nil)
      elsif @order.status == "0"
        @order.update(status: "1", picking_user: current_user)
      end
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
    authorize Order.first if @orders.empty?
  end
end
