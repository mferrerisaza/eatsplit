class DishesController < ApplicationController
  def index
    session[:order_ids] = []
    @restaurant = Restaurant.find(params[:restaurant_id])
    @dishes = policy_scope(@restaurant.dishes)
  end
end
