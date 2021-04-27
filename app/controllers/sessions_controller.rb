class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.authenticate(params[:email], params[:password])

    if @user
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Вы успешно залогинились.'
    else
      flash.now.alert = 'Неправильный емейл или пароль.'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Приходите еще!'
  end
end
