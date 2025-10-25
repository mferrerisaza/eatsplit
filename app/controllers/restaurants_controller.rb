# require "pry"

class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :location]
  after_action :verify_authorized, except: [:index, :location]

  def index
    if params[:query].blank?
      @restaurants = policy_scope(Restaurant)
    else
      @restaurants = policy_scope(filter_by_name)
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
  end

  def location
    session[:location] = nil #params[:data]

  end

  private

  def filter_by_name
    Restaurant.where("name ILIKE ?", "%#{params[:query]}%")
  end
end
