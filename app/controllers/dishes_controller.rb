class DishesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    session[:order_ids] = []
    @restaurant = Restaurant.find(params[:restaurant_id])
    @dishes = policy_scope(@restaurant.dishes)
    @starters = @dishes.select { |dish| dish.category == "Starter"}
    @mains = @dishes.select { |dish| dish.category == "Main"}
    @desserts = @dishes.select { |dish| dish.category == "Dessert"}
  end

end
