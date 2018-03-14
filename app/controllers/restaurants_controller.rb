class RestaurantsController < ApplicationController
  def index
    @restaurants = policy_scope(Restaurant).near("Carrer d'en grassot 101", 1)
    @city = request.location.city
  end
end
