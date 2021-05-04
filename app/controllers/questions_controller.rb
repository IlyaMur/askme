class QuestionsController < ApplicationController
  before_action :load_question, only: %i[show edit update destroy]
  before_action :authorize_user, except: [:create]

  def edit; end

  def create
    @question = Question.new(question_params.except(:answer))

    @question.author = current_user

    if check_captcha(@question) && @question.save
      redirect_to user_path(@question.user), notice: 'Вопрос успешно создан.'
    else
      render :edit
    end
  end

  def update
    if @question.update(question_params.except(:user_id))
      redirect_to user_path(@question.user), notice: 'Вопрос успешно сохранен.'
    else
      render :edit
    end
  end

  def destroy
    user = @question.user
    @question.destroy

    redirect_to user_path(user), notice: 'Вопрос успешно удален.'
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def authorize_user
    reject_user unless current_user == @question.user
  end

  def question_params
    params.require(:question).permit(:user_id, :text, :answer)
  end

  def check_captcha(question)
    current_user.present? ? true : verify_recaptcha(model: question)
  end
end
