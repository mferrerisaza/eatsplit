class RestaurantsController < ApplicationController
  def index
    @restaurants = filter_by_name
    @restaurants = policy_scope(@restaurants).near("carrer d'en grassot 101", 2)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
  end

  private

  def filter_by_name
    if params[:query].present?
      Restaurant.where("name ILIKE ?", "%#{params[:query]}%")
    else
      Restaurant.all
    end
  end
end
