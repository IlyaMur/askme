module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def sklonyator(number, question, questiona, questionov)
    ot10 = number % 10
    ot100 = number % 100
    if ot100.between?(11, 14) || ot10.between?(5, 9) || ot10 == 0
      return questionov
    end
    if ot10 == 1
      return question
    end
    if ot10.between?(2, 4)
      return questiona
    end
  end
end
