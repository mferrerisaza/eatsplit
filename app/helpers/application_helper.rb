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

  def order_picture(dish)
    if dish.photo.nil?
      cl_image_tag "restaurant-placeholder.jpg",
        crop: :fill,
        height: 600,
        width: 600,
        class: "order-card-image"
    else
      cl_image_tag dish.photo,
        crop: :fill,
        height: 600,
        width: 600,
        class: "order-card-image"
    end
  end

  def dish_emoji(order)
    if order.dish.category == "Starter"
      return  "<i class='em em-bowl_with_spoon'></i>".html_safe
    elsif order.dish.category == "Main"
      return "<i class='em em-shallow_pan_of_food'></i>".html_safe
    elsif order.dish.category == "Dessert"
      return "<i class='em em-cake'></i>".html_safe
    elsif order.dish.category == "Drink"
      return "<i class='em em-wine_glass'></i>".html_safe
    end
  end

  def card_photo_or_generic(user)
    if user == current_user && (user.profile.nil? || user.profile.photo.blank?)
      cl_image_tag "facebook-profile-picture-no-pic-avatar.jpg", class: "table-dashboard-user-avatar"
    elsif user == current_user
      cl_image_tag user.profile.photo, height: 300, width: 300, crop: :fill,gravity: :face, class: "table-dashboard-user-avatar"
    elsif user.profile.nil? || user.profile.photo.blank?
      cl_image_tag "facebook-profile-picture-no-pic-avatar.jpg", class: "table-dashboard-avatar"
    else
      cl_image_tag user.profile.photo, height: 300, width: 300, crop: :fill,gravity: :face, class: "table-dashboard-avatar"
    end
  end

  def feed_photo_or_generic(user)
    if user == current_user && (user.profile.nil? || user.profile.photo.blank?)
      cl_image_tag "facebook-profile-picture-no-pic-avatar.jpg", class: "avatar-large"
    elsif user == current_user
      cl_image_tag user.profile.photo, height: 300, width: 300, crop: :fill,gravity: :face, class: "avatar-large"
    elsif user.profile.nil? || user.profile.photo.blank?
      cl_image_tag "facebook-profile-picture-no-pic-avatar.jpg", class: "avatar-large"
    else
      cl_image_tag user.profile.photo, height: 300, width: 300, crop: :fill,gravity: :face, class: "avatar-large"
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
