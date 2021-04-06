module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end
end
