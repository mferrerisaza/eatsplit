module ApplicationHelper
  def card_photo_or_generic(user)
    if user.profile.nil? || user.profile.photo.blank?
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
