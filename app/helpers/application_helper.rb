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

  def card_photo_or_generic(user)
    if user == current_user && (user.profile.nil? || user.profile.photo.blank?)
      cl_image_tag "facebook-profile-picture-no-pic-avatar.jpg", class: "table-dashboard-user-avatar"
    elsif user == current_user
      cl_image_tag user.profile.photo, height: 393, width: 300, crop: :fill,gravity: :face, class: "table-dashboard-user-avatar"
    elsif user.profile.nil? || user.profile.photo.blank?
      cl_image_tag "facebook-profile-picture-no-pic-avatar.jpg", class: "table-dashboard-avatar"
    else
      cl_image_tag user.profile.photo, height: 393, width: 300, crop: :fill,gravity: :face, class: "table-dashboard-avatar"
    end
  end


  def user_name_or_generic(user)
    if user.profile.blank? == true
      return "You"
    else
      return user.profile.name
    end
  end
end
