class UsersController < ApplicationController
  before_action :load_user, except: %i[index new create]
  before_action :authorize_user, except: %i[index new create show]

  def index
    @users = User.ordered_by_id
    @hashtags = Hashtag.with_questions
  end

  def new
    redirect_to root_path, alert: 'Вы уже залогинены.' if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_path, alert: 'Вы уже залогинены.' if current_user.present?
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: 'Пользователь успешно зарегестрирован.'
      session[:user_id] = @user.id
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Пользователь успешно отредактирован.'
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Вы удалили аккаунт. Очень жаль...'
  end

  def edit; end

  def show
    @questions = @user.questions.order(created_at: :desc)

    @questions_amount = @questions.count
    @answers_amount = @questions.select(&:answer).count
    @unanswered_amount = @questions_amount - @answers_amount

    @new_question = @user.questions.build
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password,
                                 :name, :avatar_url, :header_color, :password_confirmation)
  end

  def load_user
    @user = User.find(params[:id])
  end

  def authorize_user
    reject_user unless current_user == @user
  end
end
