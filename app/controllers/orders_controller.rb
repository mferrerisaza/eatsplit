class OrdersController < ApplicationController
  def create
    dish = Dish.find(params[:dish_id])
    order = Order.create!(dish: dish)
    authorize order
    session[:order_ids] = [] if session[:order_ids].blank?
    session[:order_ids] << order.id
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
