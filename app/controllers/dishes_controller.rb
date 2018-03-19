class DishesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    session[:order_ids] = []
    session[:location] = []
    @restaurant = Restaurant.find(params[:restaurant_id])
    @dishes = policy_scope(@restaurant.dishes)
  end

end
