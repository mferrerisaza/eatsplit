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
      cl_image_path restaurant.logo,
        crop: :fill,
        height: 150,
        width: 150
    end
  end

  def dish_picture(dish)
    if dish.photo.nil?
      cl_image_tag "restaurant-placeholder.jpg",
        crop: :fill,
        height: 600,
        width: 600,
        class: "dish-card-image"
    else
      cl_image_tag dish.photo,
        crop: :fill,
        height: 600,
        width: 600,
        class: "dish-card-image"
    end
  end
end
