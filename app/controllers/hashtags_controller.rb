class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find_by!(word: params[:id])
    @questions = Question.left_joins(:hashtags).where(hashtags: @hashtag )
  end
end
