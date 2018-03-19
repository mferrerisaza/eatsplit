class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    if !params[:query].present? && params[:query].nil?
      if request.location.city == ""
        @restaurants = policy_scope(Restaurant)
      else
      @restaurants = policy_scope(Restaurant).near(request.location.city, 5)
      end
    elsif !params[:query].present? && params[:query].blank?
      @restaurants = policy_scope(Restaurant)
    else
      @restaurants = policy_scope(filter_by_name)
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
  end

  private

  def filter_by_name
    Restaurant.where("name ILIKE ?", "%#{params[:query]}%")
  end
end
