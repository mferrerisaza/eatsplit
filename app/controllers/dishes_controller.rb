class DishesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    session[:location] = []
    session[:order_ids] = []
    @restaurant = Restaurant.find(params[:restaurant_id])
    @dishes = policy_scope(@restaurant.dishes)
  end

end
