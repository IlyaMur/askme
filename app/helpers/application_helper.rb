module ApplicationHelper
  def user_avatar(user)
     user.avatar_url.presence || asset_path('avatar.jpg')
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end
end
