module ApplicationHelper
  def banner_restaurant_photo(restaurant)
    if restaurant.photo.nil?
      cl_image_path "restaurant-placeholder.jpg", crop: :fill
    else
      cl_image_path @restaurant.photo
    end
  end

  def logo_restaurant_photo(restaurant)
    if restaurant.logo.nil?
      cl_image_path "restaurant-placeholder.jpg",
        crop: :fill,
        height: 150,
        width: 150
    else
      cl_image_path @restaurant.logo,
        crop: :fill,
        height: 150,
        width: 150
    end
  end
end
