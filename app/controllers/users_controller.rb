class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Ilya',
        username: 'ilyamur',
        avatar_url: 'https://images-na.ssl-images-amazon.com/images/I/71THkrk5yOL._CR204,0,1224,1224_UX256.jpg'
      ),
      User.new(
        id: 2,
        name: 'Misha',
        username: 'aristofun'
      )
    ]
  end

  def new; end

  def edit; end

  def show
    @user =
      User.new(
        id: 1,
        name: 'Ilya',
        username: 'ilyamur',
        avatar_url: 'https://images-na.ssl-images-amazon.com/images/I/71THkrk5yOL._CR204,0,1224,1224_UX256.jpg'
      )

    @questions = [
      Question.new(text: 'Сколько байт в килобайте?', created_at: Date.parse('27.03.2021')),
      Question.new(text: 'Как дела?', created_at: Date.parse('21.05.2021'))
    ]

    @questions_amount = @questions.count
    @answers_amount = @questions.select(&:answer).count
    @unanswered_amount = @questions_amount - @answers_amount

    @new_question = Question.new
  end
end
