class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    @user_location = request.location
    if !params[:query].present? && params[:query].nil?
      if @user_location.latitude == 0 && @user_location.longitude == 0
        @restaurants = policy_scope(Restaurant)
      else
      @restaurants = policy_scope(Restaurant).near([@user_location.latitude, @user_location.longitude], 1)
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
