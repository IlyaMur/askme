class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find_by!(word: params[:id])
    @questions = @hashtag.questions
  end
end
