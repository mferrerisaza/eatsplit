class DishesController < ApplicationController
  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @dishes = policy_scope(@restaurant.dishes)
  end
end
