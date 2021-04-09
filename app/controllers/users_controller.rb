class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new; end

  def edit; end

  def show
    @user = User.find(params[:id])

    @questions = @user.questions.order(created_at: :desc)

    @questions_amount = @questions.count
    @answers_amount = @questions.select(&:answer).count
    @unanswered_amount = @questions_amount - @answers_amount

    @new_question = Question.new
  end
end
