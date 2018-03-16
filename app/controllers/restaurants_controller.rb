class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    if !params[:query].present? && params[:query].nil?
      @restaurants = policy_scope(Restaurant).near("carrer d'en grassot 101", 100)
    elsif !params[:query].present? && params[:query].blank?
      @restaurants = policy_scope(Restaurant)
    else
      @restaurants = policy_scope(filter_by_name)
    end
  end

  def show
    raise
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
  end

  private

  def filter_by_name
    Restaurant.where("name ILIKE ?", "%#{params[:query]}%")
  end
end
