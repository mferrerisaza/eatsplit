class DishesController < ApplicationController
  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @dishes = @restaurant.dishes
  end
end
