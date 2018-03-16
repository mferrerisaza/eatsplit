class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :update, :checkout]

  # def show
  #   @order = Order.where(status: 'paid').find(params[:id])
  # end

  def create
    dish = Dish.find(params[:dish_id])
    @order = Order.create!(dish: dish)
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
    if params["update"] == "plus"
      @order.quantity += 1
    elsif params["update"] == "minus"
      @order.quantity -= 1
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
