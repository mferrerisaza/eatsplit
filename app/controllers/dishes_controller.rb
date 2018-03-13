class DishesController < ApplicationController
  def index
    @restaurant = Restaurant.find(params[:id])
    @dishes = @restaurant.dishes
  end
end
